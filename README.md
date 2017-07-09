# salesforce-dev-environment
First try to set up an environment for Salesforce.

* [Docker](https://www.docker.com/)
* [Docker-compose](https://docs.docker.com/compose/)
* [Cumulusci docks](http://cumulusci.readthedocs.io/en/latest/tutorial.html)

Override default command:
`docker-compose run cumulus cci`

Change volumes in `docker-compose.yml`.

Init new project:
`docker-compose run cumulus cci project init`

Create a [Connected App](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-3-connecting-salesforce-orgs) and select `Refresh token is valid until revoked` in order to prevent token expiration.

Configure the App (add `--project` flag if multiple orgs are used):
`docker-compose run cumulus cci org config_connected_app`

Connecting an Org (prod):
`docker-compose run -p 8080:8080 cumulus cci org connect prod`

Test connected org(s): `docker-compose run cumulus cci org info prod`

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
* Make a new repository based on `skeleton` folder.
* Commit meta, see the `src-example` folder.
* Setup [CI](http://cumulusci.readthedocs.io/en/latest/cookbook.html#continuous-integration-with-cumulusci)
* Run task and check the files `project/test_results.json`, `project/test_results.xml`.
  * No parallel executing in case of one CI org.
  * Can deploy the PR to a test org, or developer's can be provided for QA.

#### Recommended Meta To Sync
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

#### Examples Provided
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

#### Setup [Drone CI](http://docs.drone.io)
* Configuration for [Bitbucket Cloud](http://docs.drone.io/install-for-bitbucket-cloud/)
* [ngrok](https://ngrok.com/) can be used for testing on localhost.
  * `./ngrok http 8081`
  * Set `DRONE_HOST` in `.env` like `http://{ngrok-hash}.ngrok.io`.
* Activate a repository.
* Enable Push and\or Pull request hooks in CI setting.
* Check created repository hook and add PR support on Create and Update.
* The docker/cumulusCI image is available as `guldmitry/cumulusci`.
* Add `CUMULUSCI_KEY` in the `Secrets` section for the activated repository.

### TODO
* On Dev Org if namespace is set - no tests are executed via `ci_feature`, see the query in logs.
  * `SELECT Id, Name FROM ApexClass WHERE NamespacePrefix = null AND (Name LIKE '%_TEST%')`
* Deploy on Production workflow.
  * cci flow run ci_master --org prod
  * cci task run run_tests_debug
  * Currently all release and install flows requires git and falls with
  * Expected to find encrypted file at /root/.cumulusci/Salesforce_Demo_Production/github.org
  * cci flow run release_beta --org prod
  * {u'errorCode': u'INVALID_TYPE', u'message': u"sObject type 'MetadataPackage' is not supported."}
* Insert a flow diagram from Gliffy.
* Linters: PMD apex, salesforce CI, eslint for lightning, 
* Demo data\fixtures via anon apex code.
* Try to register a dev org automatically.
