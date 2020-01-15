# Multichannel Service Elevator

## Generate KeyTab

Open a terminal and write this command line by line, replace "username" with your credentials to the virtual machine.

```bash
ktutil
addent -password -p username@INTRANET.IFIS.LOCAL -k 1 -e RC4-HMAC
wkt user.keytab
q

kinit -k -t user.keytab username@INTRANET.IFIS.LOCAL
```

## Getting started

1. Clone this project into your main workspace folder.

    `/home/IFIS/<username>/workspaces/`

2. Open *standalone.xml* with your editor.

    ```bash
    code standalone.xml
    ```

3. Replace "ext.esanchez" with the respective login credentials to the virtual machine(line: 401-402).

    ```xml
    <module-option name="keyTab" value="/home/IFIS/ext.esanchez/user.keytab"/>
    <module-option name="principal" value="ext.esanchez@INTRANET.IFIS.LOCAL"/>
    ```

4. Run elevator script
   
   ```bash
   bash elevator.sh
   ```

