mkdir $1
cd $1
gradle init --type java-application


echo "test {" >> app/build.gradle
echo "  testLogging {" >> app/build.gradle
echo '      events "passed", "skipped", "failed"' >> app/build.gradle
echo "  }" >> app/build.gradle
echo "}" >> app/build.gradle

echo "tasks.withType(Test).configureEach {" >> app/build.gradle
echo "  outputs.upToDateWhen { false }" >> app/build.gradle
echo "}" >> app/build.gradle
