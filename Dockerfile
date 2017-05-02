FROM fabioluciano/wso2-base
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="WSO2 - ESB"

###

ENV wso2_greb_url 'http://product-dist.wso2.com/products/governance-registry/'${wso2_greg_version}'/wso2greg-'${wso2_greg_version}'.zip'

###

WORKDIR $wso2_component_directory

RUN curl ${wso2_esb_url} \
    -H 'Referer: http://wso2.com/products/previous-products' \
    --compressed > $(basename ${wso2_esb_url}) \
 && unzip $(basename ${wso2_esb_url}) && mv wso2esb-${wso2_esb_version} esb \
 && rm wso2esb-${wso2_esb_version}.zip \
 && mkdir -p /var/log/wso2/esb/

COPY files/supervisor/* /etc/supervisor.d/

EXPOSE 8280/tcp 8243/tcp 9443/tcp
