#!/bin/sh -e
# (c) 2018-2019 Cloudera, Inc. All rights reserved.
#
#  This code is provided to you pursuant to your written agreement with Cloudera, which may be the terms of the
#  Affero General Public License version 3 (AGPLv3), or pursuant to a written agreement with a third party authorized
#  to distribute this code.  If you do not have a written agreement with Cloudera or with an authorized and
#  properly licensed third party, you do not have any rights to this code.
#
#  If this code is provided to you under the terms of the AGPLv3:
#   (A) CLOUDERA PROVIDES THIS CODE TO YOU WITHOUT WARRANTIES OF ANY KIND;
#   (B) CLOUDERA DISCLAIMS ANY AND ALL EXPRESS AND IMPLIED WARRANTIES WITH RESPECT TO THIS CODE, INCLUDING BUT NOT
#       LIMITED TO IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE;
#   (C) CLOUDERA IS NOT LIABLE TO YOU, AND WILL NOT DEFEND, INDEMNIFY, OR HOLD YOU HARMLESS FOR ANY CLAIMS ARISING
#       FROM OR RELATED TO THE CODE; AND
#   (D) WITH RESPECT TO YOUR EXERCISE OF ANY RIGHTS GRANTED TO YOU FOR THE CODE, CLOUDERA IS NOT LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, PUNITIVE OR CONSEQUENTIAL DAMAGES INCLUDING, BUT NOT LIMITED
#       TO, DAMAGES RELATED TO LOST REVENUE, LOST PROFITS, LOSS OF INCOME, LOSS OF BUSINESS ADVANTAGE OR
#       UNAVAILABILITY, OR LOSS OR CORRUPTION OF DATA.

# Incorporate helper functions
#. /opt/commons/commons.sh

#export properties_file='/opt/c2/c2-1.0.0-SNAPSHOT/conf/c2.properties'

# Nothing to do, all ENV overrides are applied by the application
# Default to binding to any interface
sed -i -e "s|^efm.server.address=.*$|efm.server.address=0.0.0.0|" $EFM_HOME'/conf/efm.properties'

sed -i -e "s|^efm.nifi.registry.enabled=.*$|efm.nifi.registry.enabled=$NIFI_REGISTRY_ENABLED|" $EFM_HOME'/conf/efm.properties'

sed -i -e "s|^efm.nifi.registry.url=.*$|efm.nifi.registry.url=$NIFI_REGISTRY|" $EFM_HOME'/conf/efm.properties'

sed -i -e "s|^efm.nifi.registry.bucketId=.*$|efm.nifi.registry.bucketId=$NIFI_REGISTRY_BUCKETID|" $EFM_HOME'/conf/efm.properties'

sed -i -e "s|^efm.nifi.registry.bucketName=.*$|efm.nifi.registry.bucketName=$NIFI_REGISTRY_BUCKETNAME|" $EFM_HOME'/conf/efm.properties'