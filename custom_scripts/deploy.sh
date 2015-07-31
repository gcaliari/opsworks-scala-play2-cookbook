#!/bin/bash

echo ''
echo ''
echo "=======> ENVIRONMENT TO DEPLOY: "
select yn in "Staging" "Production"; do
    case $yn in
        Staging ) DEPLOY_ENV='staging'; export AWS_ACCESS_KEY_ID=$OPSWORKS_DEPLOY_STAGING_ACCESS_KEY; export AWS_SECRET_ACCESS_KEY=$OPSWORKS_DEPLOY_STAGING_SECRET_KEY; break;;
        Production ) DEPLOY_ENV='production'; export AWS_ACCESS_KEY_ID=$OPSWORKS_DEPLOY_PROD_ACCESS_KEY; export AWS_SECRET_ACCESS_KEY=$OPSWORKS_DEPLOY_PROD_SECRET_KEY; break;;
    esac
done

echo ''
echo ''
echo "=======>  APPLICATION TO DEPLOY:"
select yn in "PaymentsWeb" "PaymentsBG" "CorporateWeb" "CorporateAPI" "CorporateBG" "PromotionsWeb" "PromotionsBG" "FinanceWeb" "JobsWeb"; do
    case $yn in
        PaymentsWeb ) APP='PaymentsWeb';  break;;
        PaymentsBG ) APP='PaymentsBG';  break;;
		CorporateWeb ) APP='CorporateWeb';  break;;
		CorporateAPI ) APP='CorporateAPI';  break;;
		CorporateBG ) APP='CorporateBG';  break;;
		PromotionsWeb ) APP='PromotionsWeb';  break;;
		PromotionsBG ) APP='PromotionsBG';  break;;
		FinanceWeb ) APP='FinanceWeb';  break;;
		JobsWeb ) APP='JobsWeb';  break;;
    esac
done

echo ''
echo ''
read -p "VERSION TO DEPLOY (ex: v1.1.1): " APP_VERSION
case $DEPLOY_ENV in
	staging )
		case $APP in
			PaymentsWeb ) APPLICATION='server_payments'; STACK_NAME='paymentsstaging'; LAYER_NAME='play2'; break;;
			CorporateWeb ) APPLICATION='server_corporate'; STACK_NAME="corporatestaging"; LAYER_NAME='play2'; break;;
            CorporateAPI ) APPLICATION='server_corporate'; STACK_NAME='corporatestaging'; LAYER_NAME='play2-api'; break;;
			CorporateBG ) APPLICATION='server_corporate'; STACK_NAME='corporatestaging'; LAYER_NAME='play2-background'; break;;
			PromotionsWeb ) APPLICATION='server_promotions'; STACK_NAME="promotionsstaging"; LAYER_NAME='play2'; break;;
			FinanceWeb ) APPLICATION='server_finance'; STACK_NAME="financestaging"; LAYER_NAME='play2'; break;;
			JobsWeb ) APPLICATION='server_taxijobs'; STACK_NAME="taxijobsstaging"; LAYER_NAME='play2';
		esac
		;;
	production )
		case $APP in
			PaymentsWeb ) APPLICATION='server_payments'; STACK_NAME='payments'; LAYER_NAME='play2'; break;;
			PaymentsBG ) APPLICATION='server_payments'; STACK_NAME='payments'; LAYER_NAME='play2-background'; break;;
			CorporateWeb ) APPLICATION='server_corporate'; STACK_NAME='corporate'; LAYER_NAME='play2'; break;;
            CorporateAPI ) APPLICATION='server_corporate'; STACK_NAME='corporate'; LAYER_NAME='play2-api'; break;;
			CorporateBG ) APPLICATION='server_corporate'; STACK_NAME='corporate'; LAYER_NAME='play2-background'; break;;
			PromotionsWeb ) APPLICATION='server_promotions'; STACK_NAME='promotions'; LAYER_NAME='play2'; break;;
			PromotionsBG ) APPLICATION='server_promotions'; STACK_NAME='promotions'; LAYER_NAME='play2-background'; break;;
			FinanceWeb ) APPLICATION='server_finance'; STACK_NAME="finance"; LAYER_NAME='play2'; break;;
			JobsWeb ) APPLICATION='server_taxijobs'; STACK_NAME="taxijobs"; LAYER_NAME='play2';
		esac
esac


echo ''
echo ''
echo "********************* Deploy Summary ************************"
echo "----> DEPLOY_ENV: $DEPLOY_ENV"
echo "----> APP_NAME: $APP"
echo "----> OPWKS_APPLICATION_NAME: $APPLICATION"
echo "----> APP_VERSION: $APP_VERSION"
echo "*************************************************************"

echo ''
read -p "type 'confirm' to proceed: " CONFIRM

if [ "$CONFIRM" = "confirm" ]; then
	scriptdir=`dirname "$BASH_SOURCE"`
	python $scriptdir/easy_deploy.py deploy --application=$APPLICATION rolling --stack-name=$STACK_NAME --layer-name=$LAYER_NAME --comment="Rolling deployment to all apiservers" --appversion=$APP_VERSION
else
  echo "Sorry"
fi
