# salesforce-dev-environment
First try to set up an environment for Salesforce.

* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* [cumulusci docks](http://cumulusci.readthedocs.io/en/latest/tutorial.html)

Override default command:
`docker-compose run cumulus cci`

Change the volume in `docker-compose.yml`.

Init new project:
`docker-compose run cumulus cci project init`

Create a [Connected App](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-3-connecting-salesforce-orgs) and select `Refresh token is valid until revoked` in order to prevent token expiration.

Configure the App:
`docker-compose run cumulus cci org config_connected_app`

~~Connecting an Org (prod):~~
~~`docker-compose run -p 8080:8080 cumulus cci org connect prod`~~
Workaround:
`docker-compose run -p 8080:8080 cumulus bash`
`cci org connect prod &`
`curl -XGET {callback URL with token}`

`docker-compose run cumulus cci org default prod`

### [Running Tasks](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-4-running-tasks)
Execute apex:
`docker-compose run cumulus cci task run execute_anon -o apex 'System.debug(1);'`
[Flow](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-5-flows) info:
`docker-compose run cumulus cci flow info ci_feature`
`docker-compose run cumulus cci flow run ci_feature`

### GIT Flow
* Make a new `prod` repository.
* Add a `package.xml` und empty`src` folder.
* Make a new `dev` org.
* Clone the repository.
* Follow `src/package.xml`, deploy the metadata to `dev` Force.com.
* Make changes and a pull request.
* CI: run task and check the files `project/test_results.json`, `project/test_results.xml`.
* Merge if all tests pass.
* Deploy on org(s).

## Demo
* Register two orgs: `dev` and `prod`.
* [Connect](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-3-connecting-salesforce-orgs) the orsg.
* Create a repository.
** Developer makes a fork.
* Commit meta for `prod`.
* Load the meta to `dev`.
* Make a PR to `prod`.
* Deploy the data.

### TODO
* Find out why opening `http://localhost:8080/callback` with exposed `8080` does not reach the container.
** Neither of `localhost`, `172.16.238.10`, `127.0.0.1', `0.0.0.0` works.
* Insert a flow diagram from Gliffy.

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