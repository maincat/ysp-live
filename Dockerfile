FROM python:3.12-alpine

LABEL description="央视频全频道直播代理 v9.5 旗舰版（Python 主网关 + Node.js 网页版兜底引擎，单端口）"

ENV TZ=Asia/Shanghai \
    PYTHONUNBUFFERED=1 \
    YSP_DATA_DIR=/app/data

RUN (apk add --no-cache nodejs tzdata ca-certificates || (sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --no-cache nodejs tzdata ca-certificates)) && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    mkdir -p /app /app/data

WORKDIR /app

COPY ysp-live.py ysp-engine.js ./

VOLUME ["/app/data"]

EXPOSE 8767

CMD ["sh", "-c", "mkdir -p /app/data && chmod -R 777 /app/data 2>/dev/null || true; exec python3 -u ysp-live.py 8767"]
