# salesforce-dev-environment
First try to set up an environment for Salesforce.

* [Docker](https://www.docker.com/)
* [Docker-compose](https://docs.docker.com/compose/)
* [Cumulusci docks](http://cumulusci.readthedocs.io/en/latest/tutorial.html)

Override default command:
`docker-compose run cumulus cci`

Change the volume in `docker-compose.yml`.

Init new project:
`docker-compose run cumulus cci project init`

Create a [Connected App](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-3-connecting-salesforce-orgs) and select `Refresh token is valid until revoked` in order to prevent token expiration.

Configure the App:
`docker-compose run cumulus cci org config_connected_app`

Connecting an Org (prod):
`docker-compose run -p 8080:8080 cumulus cci org connect prod`

Or workaround in case of bridge network:
* `docker-compose run -p 8080:8080 cumulus bash`
* `cci org connect prod &`
* `curl -XGET {callback URL with token}`

`docker-compose run cumulus cci org default prod`

### [Running Tasks](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-4-running-tasks)
Execute apex:
`docker-compose run cumulus cci task run execute_anon -o apex 'System.debug(1);'`

[Flow](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-5-flows) info:

`docker-compose run cumulus cci flow info ci_feature`

`docker-compose run cumulus cci flow run ci_feature`

### GIT Flow
* Make a new `prod` repository based on `sleketon`.
* Make a new `dev` org.
* Clone the repository.
* Follow `src/package.xml`, deploy the metadata to `dev` Force.com.
* Make changes and a pull request.
  * Populate `src/package.xml` with new data, example for class, test and new object:
      ```
      src/classes/TestClass.cls
      src/classes/TestClass.cls-meta.xml
      src/classes/TestClassTest.cls
      src/classes/TestClassTest.cls-meta.xml
      src/objectTranslations/New_Object__c-en_US.objectTranslation
      src/objects/New_Object__c.object
      src/layouts/New_Object__c-New Object Layout.layout
      ```
      ```xml
        <types>
            <members>TestClass</members>
            <members>TestClassTest</members>
            <name>ApexClass</name>
        </types>
        <types>
            <members>New_Object__c.String__c</members>
            <name>CustomField</name>
        </types>
        <types>
            <members>New_Object__c</members>
            <name>CustomObject</name>
        </types>
        <types>
            <members>New_Object__c-en_US</members>
            <name>CustomObjectTranslation</name>
        </types>
        <types>
            <members>New_Object__c-New Object Layout</members>
            <name>Layout</name>
        </types>
    ```
* [CI](http://cumulusci.readthedocs.io/en/latest/cookbook.html#continuous-integration-with-cumulusci): run task and check the files `project/test_results.json`, `project/test_results.xml`.
  * No parallel executing in case of one CI org.
  * Can deploy the PR to a test org, or developer's can be provided for QA.
* Merge if all tests pass.
* Deploy on org(s) manually or hook.

### Recommended Meta To Sync
* ApexClass
* ApexComponent
* ApexPage
* ApexTrigger
* AuraDefinitionBundle
* CustomApplication
* CustomLabels
* CustomObjectTranslation
* CustomPageWebLink
* CustomSite
* CustomTab
* DataCategoryGroup
* FieldSet
* Flow
* Group
* HomePageComponent
* HomePageLayout
* Layout
* PermissionSet
* Portal
* Profile
* Queue
* RecordType
* RemoteSiteSetting
* ReportType
* Role
* Scontrol
* Workflow
* StaticResource

## Setup [Drone CI](http://docs.drone.io)
* Configuration for [Bitbucket Cloud](http://docs.drone.io/install-for-bitbucket-cloud/)
* [ngrok](https://ngrok.com/) can be used for testing on localhost.
  * `./ngrok http 8081`
  * Set `DRONE_HOST` in `.env` like `http://{ngrok-hash}.ngrok.io`.
* Activate a repository.
* Enable Push and\or Pull request hooks in CI setting.
* Check created repository hook and add PR support on Create and Update.
* The docker/cumulusCI image is available as `guldmitry/cumulusci`.
* Add `CUMULUSCI_KEY` in the `Secrets` section for the activated repository.

### Demo
* Register two orgs: `dev` and `prod`.
* [Connect](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-3-connecting-salesforce-orgs) the orsg.
* Create a repository `prod` from the `skeleton` folder.
  * Developer makes a fork.
* Commit initial data.
* Clone the repository `dev`.
* Make a PR to `prod`.
* Run drone CI `docker-compose -f docker-compose-drone.yml up`.
* Check the build.
* Deploy the data.

### TODO
* Deploy on Production workflow.
  * cci flow run ci_master --org prod
  * cci flow run release_beta --org prod
  * [Error](https://github.com/SalesforceFoundation/CumulusCI/issues/209) {u'errorCode': u'INVALID_TYPE', u'message': u"sObject type 'MetadataPackage' is not supported."}
  * Currently all release and install flows requires git and falls with
  * Expected to find encrypted file at /root/.cumulusci/Salesforce_Demo_Production/github.org
* Insert a flow diagram from Gliffy.
* Linters: PMD apex, salesforce CI, eslint for lightning, 
* Demo data\fixtures via anon apex code.
* Try to register a dev org automatically.

#### Commit meta
- [x] Custom Object.
- [x] Custom fields for Custom Object.
- [x] Apex Class and Test.
- [ ] Custom Labels.
- [ ] Custom Settings.
- [ ] Update Layout.
- [ ] Lightning App.
- [ ] Lightning Controller.
- [ ] One App.
- [ ] Validation Rule.
- [ ] Lookup Filter.
- [ ] Master-Detail.
- [ ] Lookup.
- [ ] Workflow.
