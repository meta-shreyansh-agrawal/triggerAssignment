@isTest
private class AllObjectsTest {


@IsTest
    static void testGetAllSObjectNames() {
        List<String> objectNames = AllObjects.getAllSObjectNames();
        System.assert(objectNames.size() > 0, 'Expected at least one SObject name');
    }
}