# Multichannel Service Composer

## Getting Started

1. Generate KeyTab.

   Open a terminal and execute these commands line by line, replace "username" with your virtual machine access credentials.

    ```bash
    ktutil
    addent -password -p username@INTRANET.IFIS.LOCAL -k 1 -e RC4-HMAC
    wkt user.keytab
    q

    kinit -k -t user.keytab username@INTRANET.IFIS.LOCAL
    ```

2. Clone this project into your main workspaces folder.

    `/home/IFIS/username/workspaces/`

3. Open *standalone.xml* with your editor.

    ```bash
    code standalone.xml
    ```

4. Replace "ext.esanchez" with the respective login credentials to the virtual machine(line: 401-402).

    ```xml
    <module-option name="keyTab" value="/home/IFIS/ext.esanchez/user.keytab"/>
    <module-option name="principal" value="ext.esanchez@INTRANET.IFIS.LOCAL"/>
    ```

5. Run composer script.

   ```bash
   bash composer.sh
   ```

## Runner

1. If you need to execute the project.

   ```bash
   bash runner.sh
   ```

   if you need build include `--build` param.

    ```bash
    bash runner.sh --build
    ```

2. Use Ctrl-C to stop.
