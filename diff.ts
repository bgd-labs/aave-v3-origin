#!/usr/bin/env node

import {ethers} from 'ethers';
import {CONTRACTS, PROXIES, CHAIN_ID, Networks} from './diff_config';
import child_process from 'child_process';
import dotenv from 'dotenv';
import fs from 'fs';
dotenv.config();

function runCmd(cmd: string) {
  var resp = child_process.execSync(cmd);
  var result = resp.toString();
  return result;
}

const API_KEYS = {
  [Networks.SONEIUM]: process.env.ETHERSCAN_API_KEY_SONEIUM,
  [Networks.LINEA]: process.env.ETHERSCAN_API_KEY_LINEA,
  [Networks.FACTORY_LOCAL]: undefined,
};

const RPC_URLS = {
  [Networks.SONEIUM]: process.env.RPC_SONEIUM,
  [Networks.LINEA]: process.env.RPC_LINEA,
  [Networks.FACTORY_LOCAL]: undefined,
};

async function download(network: Networks, contractName: string, address: string) {
  if (!fs.existsSync(`downloads/${network}/${contractName}`)) {
    console.log('downloading', contractName);
    if (network === Networks.SONEIUM) {
      await downloadSoneiumSource(network, contractName, address);
    } else {
      runCmd(
        `cast source --chain-id ${CHAIN_ID[network]} -d downloads/${network}/${contractName} ${address} --etherscan-api-key ${API_KEYS[network]}`
      );
    }
  }
}

async function downloadSoneiumSource(network: Networks, contractName: string, address: string) {
  const payload = {
    address,
    module: "contract",
    action: "getsourcecode",
    apikey: "any"
  };
  const formattedPayload = new URLSearchParams(payload).toString();
  const url = `https://soneium.blockscout.com/api?${formattedPayload}`;
  const request = await fetch(url);
  const response = await request.json();

  const { status, message, result } = response as {
    message: string;
    result: {
      ABI: any;
      CompilerVersion: string;
      ConstructorArguments: string;
      ContractName: string;
      EVMVersion: string;
      Implementation: string;
      Library: string;
      LicenseType: string;
      OptimizationUsed: string;
      Proxy: string;
      Runs: string;
      SimilarMatch: string;
      SourceCode: string;
      FileName: string;
      AdditionalSources: [{
        SourceCode: string;
        Filename: string;
      }]
    }[];
    status: string;
  };

  if (!result || !result[0]) {
    console.error('No result found in API response');
    return;
  }

  const path = `downloads/${network}/${contractName}`;
  const file = `${path}/${result[0].FileName}`;

  const fileDir = file.substring(0, file.lastIndexOf('/'));
  fs.mkdirSync(fileDir, { recursive: true });

  fs.writeFile(`${path}/${result[0].FileName}`, result[0].SourceCode, { flag: 'a+' }, (err) => {
    if (err) {
      console.error('Error writing file:', err);
      return;
    }
  });

  // Handle additional source files
  if (result[0].AdditionalSources && Array.isArray(result[0].AdditionalSources)) {
    for (const source of result[0].AdditionalSources) {
      const additionalFilePath = `${path}/${source.Filename}`;
      const additionalFileDir = additionalFilePath.substring(0, additionalFilePath.lastIndexOf('/'));
      fs.mkdirSync(additionalFileDir, { recursive: true });
      fs.writeFile(additionalFilePath, source.SourceCode, { flag: 'a+' }, (err) => {
        if (err) {
          console.error('Error writing additional file:', err);
          return;
        }
      });
    }
  }
}

function getImpl(network: Networks, address: string) {
  const x = runCmd(
    `cast storage --rpc-url ${RPC_URLS[network]} ${address} 24440054405305269366569402256811496959409073762505157381672968839269610695612 --etherscan-api-key ${API_KEYS[network]}`
  ).replace('\n', '');
  return ethers.getAddress(x.slice(-40));
}

function diffContracts(commonContracts: string[], network1: string, network2: string) {
  try {
    commonContracts.map((contractName) => {
      PROXIES.includes(contractName) && (contractName = contractName + '_IMPL');
      const sourcePathNetwork1 =
        network1 != 'FACTORY_LOCAL'
          ? `./downloads/${network1}/${contractName}.sol`
          : `./downloads/FACTORY_LOCAL/${contractName}.sol`;
      const sourcePathNetwork2 =
        network2 != 'FACTORY_LOCAL'
          ? `./downloads/${network2}/${contractName}.sol`
          : `./downloads/FACTORY_LOCAL/${contractName}.sol`;
      const outPath = `${network1}_${network2}/${contractName}_DIFF`;
      runCmd(
        `make git-diff before=${sourcePathNetwork1} after=${sourcePathNetwork2} out=${outPath}`
      );
    });
  } catch (e) {
    console.log(e);
    throw new Error('oops... failed to diff contracts');
  }
}

function flatten(network: string, name: string, path: string) {
  console.log('flattening contract', name);
  const sourcePath =
    network != 'FACTORY_LOCAL' ? `./downloads/${network}/${name}/${path}` : `./${path}`;
  const outPath =
    network != 'FACTORY_LOCAL'
      ? `./downloads/${network}/${name}.sol`
      : `./downloads/FACTORY_LOCAL/${name}.sol`;
  runCmd(`forge flatten ${sourcePath} --output ${outPath}`);
}

async function downloadContracts(commonContracts: string[], network: Networks) {
  await Promise.all(commonContracts.map(async (key) => {
    const isProxy = PROXIES.includes(key);
    const contractName = isProxy ? `${key}_IMPL` : key;
    const address = isProxy
      ? getImpl(network, CONTRACTS[network][key].address as string)
      : CONTRACTS[network][key].address;
    await download(network, contractName, address as string);
  }));
}

function flattenContracts(commonContracts: string[], network: Networks) {
  commonContracts.map((key) => {
    const isProxy = PROXIES.includes(key);
    const contractName = isProxy ? `${key}_IMPL` : key;
    flatten(network, contractName, CONTRACTS[network as keyof typeof CONTRACTS][key].path);
  });
}

async function main() {
  // get networks to diff against from the command line input
  const network1 = process.argv[2] as Networks;
  const network2 = process.argv[3] as Networks;

  console.log(`comparing diffs between ${network1}, ${network2}`);

  // find all the common contracts to compare between both the networks.
  const commonContracts = Object.keys(CONTRACTS[network1 as keyof typeof CONTRACTS]).filter((key) =>
    CONTRACTS[network2 as keyof typeof CONTRACTS].hasOwnProperty(key)
  );

  if (network1 != 'FACTORY_LOCAL') {
    await downloadContracts(commonContracts, network1);
  }
  if (network2 != 'FACTORY_LOCAL') {
    await downloadContracts(commonContracts, network2);
  }

  flattenContracts(commonContracts, network1);
  flattenContracts(commonContracts, network2);

  diffContracts(commonContracts, network1, network2);
}

main();
