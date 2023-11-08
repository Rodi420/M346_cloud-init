----------------------------------------------------------------------------------------------------
HOW TO USE
----------------------------------------------------------------------------------------------------

    edit docker-compose.yaml and replace any standard values
    tagged with caps locked "REPLACE" at the beginning
    
    use docker compose to start the containers

    $ docker compose up (--detach)

    access your gitlab instance with localhost:80 or 443
    adjust firewall rules for those ports if needed

    CAUTION WITH VMs
    if you are using NAT network, gitlab will be able to send emails

    if you are using BRIDGED watch out for firewall rules regarding emails! 

----------------------------------------------------------------------------------------------------
FIND ROOT PASSWORD
----------------------------------------------------------------------------------------------------

    this can be set using following environment variable:
        gitlab_rails['initial_root_password'] = "REPLACE"

    otherwise you can grep it from the initial_root_password file
        $ sudo docker exec -it "yourGitlab" grep 'Password:' /etc/gitlab/initial_root_password

    3rd variant (opens shell terminal):
        $ sudo docker exec -it "yourGitlab" /bin/bash

----------------------------------------------------------------------------------------------------
TEST SMTP CONNECTIONS
----------------------------------------------------------------------------------------------------

    go inside shell terminal of your gitlab and start the rails console
        $ gitlab-rails console

    using following snippet send a test email to your desired recipient:
        Notify.test_email('destination@email.com', 'Subject', 'Body').deliver_now

    if this error occurs it means that the DNS/FIREWALL isnt set correctly! (BRIDGED probably)
    	getaddrinfo: Temporary failure in name resolution (SocketError)
    open following ports if this occurs:
        25 (SMTP)
        537 (TLS)
    applies to outlook smtp since gmail denies any SMTP attempts

    check if smtp is activated:
        ActionMailer::Base.delivery_method

    check current smtp config:
        ActionMailer::Base.smtp_settings

    mails sent by gitlab will use either the variable "external_url" or "hostname"
    so if you get a mail it will say to go to "external_url".com/exampleUrlInsideGitlab
    adjust this with a direct ip adress or setup a functioning DNS

    to see logs use following command:
        $ sudo docker logs -f "yourGitlab" (or your custom container name)
----------------------------------------------------------------------------------------------------
GRAFANA
----------------------------------------------------------------------------------------------------
    
    untested and requires enterprise licence to use their gitlab plugin

----------------------------------------------------------------------------------------------------