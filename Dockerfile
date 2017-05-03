FROM fabioluciano/wso2-base
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="WSO2 - GReg"

###

ENV wso2_component 'greg'
ENV wso2_component_version '5.4.0'
ENV wso2_component_url 'http://product-dist.wso2.com/products/governance-registry/'${wso2_component_version}'/wso2'${wso2_component}'-'${wso2_component_version}'.zip'

###

WORKDIR $wso2_component_directory

RUN echo ${wso2_component_url} \ 
&& curl ${wso2_component_url} \
    -H 'Referer: http://wso2.com/products/previous-products' \
    --compressed > $(basename ${wso2_component_url}) \
  && unzip -qq $(basename ${wso2_component_url}) && mv wso2${wso2_component}-${wso2_component_version} ${wso2_component} \
  && rm wso2${wso2_component}-${wso2_component_version}.zip \
  && chown -R wso2:wso2 ${wso2_component_directory}/${wso2_component} \
  && mkdir -p /var/log/wso2/${wso2_component}/

COPY files/supervisor/* /etc/supervisor.d/

EXPOSE 9763/tcp 9443/tcp
