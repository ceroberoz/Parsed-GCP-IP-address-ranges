GCP IP address ranges from https://www.gstatic.com/ipranges/cloud.json

Parsed per region and IPs (v4 & v6) for convinience.

![alt text](https://github.com/ceroberoz/Parsed-GCP-IP-address-ranges/blob/main/parsed-gcp-ip.jpeg?raw=true)

IP range checked and updated schedule to run at midnight (UTC time) on daily basis.

---

Too impatient waiting for daily update? Run fetch-aws-ip-ranges.sh script directly on your Linux / Mac terminal.

Required `curl` and `jq` installed before running Shell below.

Short URL
```
curl -fsSL https://s.id/parsed-gcp-ip | sh
```

Long URL
```
curl -fsSL https://raw.githubusercontent.com/ceroberoz/Parsed-GCP-IP-address-ranges/main/fetch-gcp-ip-ranges.sh | sh
```
