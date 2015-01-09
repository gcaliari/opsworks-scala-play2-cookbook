1. Install PIP (Tested in MACOS)

_$ sudo easy_install pip

2. Install dependencies

_$ pip install click==3.3
_$ pip install botocore==0.64.0
_$ pip install arrow==0.4.4

3. Put deploy.sh on PATH

4. Put on ENV 
	OPSWORKS_DEPLOY_PROD_ACCESS_KEY
	OPSWORKS_DEPLOY_PROD_SECRET_KEY 
	OPSWORKS_DEPLOY_STAGING_ACCESS_KEY 
	OPSWORKS_DEPLOY_STAGING_SECRET_KEY 

5. Execute

_$ deploy.sh
