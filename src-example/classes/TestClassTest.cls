@IsTest
private class TestClassTest {

    @IsTest
    static void testHelloWorld1() {
        Test.startTest();
        String actual = TestClass.helloWorld();
        Test.stopTest();

        System.assertEquals('Hello World!', actual);
    }
}