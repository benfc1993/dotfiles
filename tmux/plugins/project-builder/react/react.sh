#!/bin/bash
wd=$1

read -p "project-name:" name

echo "$name"

if [[ -z "$name" ]];
then
    exit 0 
fi

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

echo "React builder $name"
full_path="$wd/$name"
cd $wd

npm create vite@latest $name -- --template react-swc-ts

cd $full_path

npm i

rm -rf tsconfig.json
cp "$script_path/tsconfig.json" ./tsconfig.json


cp "$script_path/jest.config.ts" ./jest.config.ts

cp "$script_path/setupTests.ts" ./setupTests.ts

cp "$script_path/.babelrc" ./.babelrc

rm -f ./src/App.ts
cp "$script_path/App.tsx" ./src/App.ts

cp "$script_path/App.test.tsx" ./src/App.test.ts

npm i -D ts-node jest ts-jest jest-environment-jsdom jest-svg-transformer identity-obj-proxy @babel/preset-env @babel/preset-react @testing-library/jest-dom @testing-library/react

npx npm-add-script \
-k "test" \
-v "jest" \
--force

read -n 1 -p "React project $name created, press any key to exit."
