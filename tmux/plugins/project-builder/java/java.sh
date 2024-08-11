wd=$1

read -p "project-name:" name

echo "$name"

if [[ -z "$name" ]];
then
    exit 0 
fi

full_path="$wd/$name"

mkdir $full_path
cd $full_path
gradle init --type java-application

echo "test {" >> app/build.gradle
echo "  testLogging {" >> app/build.gradle
echo '      events "passed", "skipped", "failed"' >> app/build.gradle
echo "  }" >> app/build.gradle
echo "}" >> app/build.gradle

echo "tasks.withType(Test).configureEach {" >> app/build.gradle
echo "  outputs.upToDateWhen { false }" >> app/build.gradle
echo "}" >> app/build.gradle

read -n 1 -p "Java project $name created, press any key to exit."
