#!/bin/bash
wd=$1

read -p "project-name:" name

echo "$name"

if [[ -z "$name" ]];
then
    exit 0 
fi

echo "typescript builder $name"
full_path="$wd/$name"
mkdir $full_path
cd $full_path

npm init -y

npm i -D typescript ts-node ts-node-dev jest ts-jest @types/jest @types/node esbuild
npx ts-jest config:init
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
-k "test-watch" \
-v "jest --watchAll" \
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

echo "{" >> .prettierrc
echo "	\"tabWidth\": 4," >> .prettierrc
echo "	\"useTabs\": false," >> .prettierrc
echo "	\"semi\": false," >> .prettierrc
echo "	\"singleQuote\": true", >> .prettierrc
echo "	\"trailingComma\": \"none\"" >> .prettierrc
echo "}" >> .prettierrc

read -n 1 -p "Typescript project $name created, press any key to exit."
