
# Youtrack / KeyCloak / Traefik

Sample docker-compose deployment for YouTrack with KeyCloak for auth and Traefik
as a reverse proxy.

The included SSL certificates & keys are self-signed and issued to `localhost`.

## Setup



1. Create the "public" docker network.


   ```bash
   docker network create public_web --attachable
   ```

2. Update `/etc/hosts` to access youtrack & keycloak in your browser. Replace
   the IP with your DHCP address ( do not use `127.0.0.1` ).

   ```
   echo '
   192.168.10.123 keycloak.localhost youtrack.localhost
   ' | sudo tee -a /etc/hosts
   ```

3. Pull the docker images (optional).

   ```bash
   docker-compose pull
   ```

4. Build docker images for YouTrack.

   ```bash
   docker-compose build
   ```

5. Start the stack.

   ```bash
   docker-compose up
   ```

6. Open `keycloak` in your browser.

   ```bash
   firefox https://keycloak.localhost/auth
   ```

7. Create a new client with the `Client Id` of `youtrack` and `Root URL` of
   `https://youtrack.localhost`.
   
   Set the `Access Type` field to `confidential` and click `Save` at the bottom of the page.

   Navigate to the `Credentials` tab to find the `Secret` used to register the
   YouTrack auth module later.

   Create a user & set their password, uncheck the `Temporary` button before
   hitting `Save`.

8. Find the YouTrack setup wizard token.

   ```bash
   docker-compose exec youtrack cat /opt/youtrack/conf/internal/services/configurationWizard/wizard_token.tx
   ```

9. Open YouTrack in your browser and complete the setup wizard.

   ```bash
   firefox https://youtrack.localhost
   ```

10. Setup a `KeyCloak` auth module using the `Client Id` and `Secret` from step
    7.
