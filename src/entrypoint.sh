#!/bin/bash

cat <<EOF
                                                                                
                                                                                
                              ::::::::::::::::::::::-=.                         
                           .-=-=--::::::::::::::::==-:.                         
                          :---=--=-=---::::::::-===-::.                         
                         :==-=-=--=-=-=-=---:=====::::.                         
                         ===--=-=--=---=-======+=:::::.                         
                        .====--=-=------=============-.                         
                        .====-=---:         =+========.                         
                        .=====-=-=:         -=========.                         
                        .=====-=++=         :=========.                         
                        .=====++++=         :=========.                         
                        .=====++++=         :=========.                         
                        :======++++====-::::-=========.                         
                        :======+++++++================.                         
                        :=======+++++================-                          
                        :========+++================-                           
                        :========+=================:                            
                        :========:==============-.                              
                        :++++++=                                                
                        :+++++:                                                 
                        :++++.                                                  
                        :++=                                                    
                        :+=                                                     
                        ::                                                      
                                                                                
                                                                                
EOF

echo "Starting Papercut MF..."
# Perform only if Papercut service exists and is executable.
if [[ -x /etc/init.d/papercut ]]; then

    # Fixing permissions after any volume mounts.
    echo "Settings permissions..."
    chown -R papercut:papercut /papercut
    chmod +x /papercut/server/bin/linux-x64/setperms
    /papercut/server/bin/linux-x64/setperms

    echo "Setting server config..."
    sudo -u papercut -H cat /server.properties.template | envsubst | tee /papercut/server/server.properties
    sudo -u papercut -H cat /security.properties.template | envsubst | tee /papercut/server/security.properties
    cat /smb.conf.template | envsubst | tee /etc/samba/smb.conf

    # database needs to initialized
    sudo -u papercut -H /papercut/server/bin/linux-x64/db-tools init-db -q

    # If an import hasn't been done before and a database backup file name
    # 'import.zip' exists, perform import.
    if [[ -f /papercut/import.zip ]] && [[ ! -f /papercut/import.log ]]; then
        sudo -u papercut -H /papercut/server/bin/linux-x64/db-tools import-db -q -f /papercut/import.zip
    fi

    # Copy UUID file from backup
    if [[ -f /papercut/server/data/conf/server.uuid ]]; then
        echo "Restoring UUID file..."
        sudo -u papercut -H cp /papercut/server/data/conf/server.uuid /papercut/server/server.uuid
        chown -R papercut:papercut /papercut/server/server.uuid
    fi

    # Copy license file from backup
    if [[ -f /papercut/server/data/conf/application.license ]]; then
        echo "Restoring license file..."
        sudo -u papercut -H cp /papercut/server/data/conf/application.license /papercut/server/application.license
        chown -R papercut:papercut /papercut/server/application.license
    fi

    echo "Starting Papercut services..."
    /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
else
    echo "Papercut service not found or is not executable. Exiting..."
fi
