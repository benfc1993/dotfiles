#!/bin/bash

echo $PATH

echo "typescript builder $1"

mkdir $1
cd $1

npm init -y

yarn add -D typescript ts-node ts-node-dev jest ts-jest @types/jest @types/node esbuild
yarn ts-jest config:init
tsc --init

npx npm-add-script \
-k "dev" \
-v "ts-node-dev --respawn --watch src src/index.ts" \
--force

npx npm-add-script \
-k "test" \
-v "jest" \
--force

npx npm-add-script \
-k "build" \
-v "esbuild src/index.ts --minify --bundle --outdir=dist" \
--force

mkdir src
touch src/index.ts

echo "export const main = () => 'Hello world!'" >> src/index.ts
echo "" >> src/index.ts
echo "console.log(main())" >> src/index.ts

echo "import { main } from '.'" >> src/index.test.ts
echo "it('should return a welcome message', () => expect(main()).toBe('Hello world!'))" >> src/index.test.ts

nvim $1

