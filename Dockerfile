FROM bitnami/nginx-ingress-controller:1.12.1 AS ingress
FROM openresty/openresty:1.27.1.1-3-alpine-fat

RUN ln /usr/local/openresty/nginx/sbin/nginx /usr/bin/

RUN rm /usr/local/openresty/nginx/html/index.html
COPY --from=ingress /nginx-ingress-controller /nginx-ingress-controller

RUN set -e -x; apk add libcap-setcap; \
    setcap -r /nginx-ingress-controller; \
    rm -rf /var/cache/apk/*

RUN addgroup -g 1001 nginx && \
    adduser -u 1001 -G nginx -s /bin/sh -D nginx && \
    chown -R nginx:nginx /tmp/nginx /etc/nginx /etc/ingress-controller /var/run/openresty

USER 1001

ENTRYPOINT ["/nginx-ingress-controller", "--http-port=8080", "--https-port=8443"]

COPY --from=ingress /etc/nginx/nginx.conf /etc/nginx/nginx.conf
RUN chown root:root /etc/nginx/nginx.conf
RUN chmod 666 /etc/nginx/nginx.conf

COPY --from=ingress /etc/nginx/lua /etc/nginx/lua

RUN mkdir -p /tmp/nginx /etc/ingress-controller /etc/ingress-controller/telemetry /etc/nginx/static
RUN cp /usr/local/openresty/nginx/conf/mime.types /etc/nginx/

RUN chmod 1777 /tmp/nginx/ \
    /etc/nginx/ \
    /etc/nginx/lua/ \
    /etc/ingress-controller/ \
    /etc/ingress-controller/telemetry/ \
    /var/run/openresty/ \
    /etc/nginx/static/

COPY nginx.tmpl /etc/nginx/template/
COPY src/banner.js /etc/nginx/static/

ENV LD_LIBRARY_PATH=/usr/local/openresty/luajit/lib:/usr/local/openresty/pcre2/lib:/usr/local/openresty/openssl3/lib
