FROM fabioluciano/wso2-base
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="WSO2 - GReg"

###

ENV wso2_component 'greg'
ENV wso2_component_version '5.4.0'
ENV wso2_component_url 'http://product-dist.wso2.com/products/governance-registry/'${wso2_component_version}'/wso2_'${wso2_component}'-'${wso2_component_version}'.zip'

###

WORKDIR $wso2_component_directory

RUN curl ${wso2_component_url} \
    -H 'Referer: http://wso2.com/products/previous-products' \
    --compressed > $(basename ${wso2_component_url}) \
  && unzip $(basename ${wso2_component_url}) && mv wso2${wso2_component}-${wso2_component_version} {wso2_component} \
  && rm wso2{wso2_component}-${wso2_component_version}.zip \
  && mkdir -p /var/log/wso2/{wso2_component}/

COPY files/supervisor/* /etc/supervisor.d/

EXPOSE 8280/tcp 8243/tcp 9443/tcp
