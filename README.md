# salesforce-dev-environment
First try to set up an environment for Salesforce.

* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* [cumulusci docks](http://cumulusci.readthedocs.io/en/latest/tutorial.html)

Change the volume in `docker-compose.yml`.

Override default command:
`docker-compose run cumulus cci`

Init new project:
`docker-compose run cumulus cci project init`

## Demo
* Register two orgs: `dev` and `prod`.
* [Connect](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-3-connecting-salesforce-orgs) the orsg.
* Create a repository.
** Developer makes a fork.


### TODO
* Insert a flow diagram from Gliffy.
