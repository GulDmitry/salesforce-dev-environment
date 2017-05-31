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

### GIT flow
* Make a new `prod` repository.
* Download required meta into `src` folder and push.
* Make a new `dev` org.
* Clone the repository.
* Follow `src/package.xml`, deploy the metadata to `dev` Force.com.

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

### Recomended Meta to Sync
* ApexClass
* ApexComponent
* ApexPage
* ApexTrigger
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