# Описание переменных для роли Кафки

## Описание групповых переменных

```
#Задаем тип инсталляции. Обязательное поле.
kafka_type: "cluster"

#Состав кластера Zookeeper. Обязательное поле в режиме кластера.
zookeeper_cluster:
  - zookeeper-infra01
  - zookeeper-infra02
  - zookeeper-infra03

#Состав кластера Брокеров. Обязательное поле в режиме кластера.
kafka_access_hosts:
  - kafka-infra01
  - kafka-infra02 
  - kafka-infra03 

#Необходимые опции если устанавливаем Telegraf (мониторинг). Нужные если устанавливаем мониторинг.
telegraf_directory: /etc/telegraf
telegraf_user: telegraf
telegraf_group: telegraf

#Задаем кредлы для авторизации на брокере и Зоокипере. Обязательное поле.
kafka_zookeeper_admin: "{{ vault_kafka_zookeeper_admin }}"
kafka_zookeeper_admin_password: "{{ vault_kafka_zookeeper_admin_password }}"
kafka_zookeeper_user: "{{ vault_kafka_zookeeper_user }}"
kafka_zookeeper_password: "{{ vault_kafka_zookeeper_password }}"
kafka_server_username: "{{ vault_kafka_server_username }}"
kafka_server_password: "{{ vault_kafka_server_password }}"

#Переопределеям дефолтное количество партишенов. Необязательное поле т.к. есть в дефолтах, но его желательно выставить в соответсвии с размером кластера.
kafka_num_partitions: 3

#Переопределяем версию Кафки. Желательно выставить 2.8 т.к. это последняя версия ветки 2.х
kafka_version: 2.8.1
kafka_scala_version: 2.12

#Разрешенные сети для доступа к брокеру. Обязательное поле.
kafka_accepted_networks:
#infra
  - 10.67.8.0/21
#vpn
  - 10.67.240.0/23

Разрешенные сети для доступа к Зоокиперу. Обязательное поле.
zookeeper_accepted_networks:
#infra
  - 10.67.8.0/21
#vpn
  - 10.67.240.0/23</pre>
```

## Описание хостовых переменных

### Брокеры

```
#ID брокера в кластере. Поле должно быть уникальным. Обязательное поле в режиме кластера.
kafka_broker_id: 1
#ID стойки  в кластере. Поле желательно установить уникальным. Нужно для того чтобы реплики не собирались на соседних нодах если серверы стоят в одной стойке. Обязательное поле в режиме кластера.
broker_rack: RACK1
kafka_external_logging: true
#Признак нахождения брокера на хосте. Обязательное поле в режиме кластера.
broker_node: true
```

### Зоокипер

```
#Признак установки Зоокипера нативно на хост. Обязательное поле в режиме кластера.
zookeeper_type: host
#ID Зоокипера в кластере. Поле должно быть уникальным. Обязательное поле в режиме кластера.
zookeeper_id: 1
backup_zookeeper: true
#Признак нахождения Зоокипера на хосте. Обязательное поле в режиме кластера.
zookeeper_node: true
```

## Проверка работы инсталляции Кафки

Самым простым способом проверки работы кластера явлется запуск контейнера с распространенной админкой для Кафки [kafka-ui](https://github.com/provectus/kafka-ui).

### Пример

```
docker run --rm -p 8081:8080 \
-e KAFKA_CLUSTERS_0_NAME=kafka-infra \
-e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=broker_ip:broker_port \
-e KAFKA_CLUSTERS_0_ZOOKEEPER=zoo_host:zoo_port \
-e KAFKA_CLUSTERS_0_PROPERTIES_SECURITY_PROTOCOL=SASL_PLAINTEXT \
-e KAFKA_CLUSTERS_0_PROPERTIES_SASL_MECHANISM=SCRAM-SHA-256 \
-e KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG='org.apache.kafka.common.security.scram.ScramLoginModule required username="broker_username" password="broker_pass";' \
     provectuslabs/kafka-ui:latest
```

В зависимости от настроек конкретной инсталляции Кафки потребуется заменить следующие параметры на свои
| Переменная | Значение
| ------ | ------ |
| `broker_ip:broker_port` | IP:порт брокера |
| `zoo_host:zoo_port` | IP:порт Зоокипера |
| `broker_username` | Логин для SASL авторизации |
| `broker_pass` | Пасс для SASL авторизации |

Также можно обойтись стандартными скриптами из комплекта Кафки. На машине должна быть JRE.

Для авторизации клиента нужен файл с properties в котором описываются параметры подключения к брокеру, в т.ч. параметриы авторизации.

### Пример properties файла

```
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="broker_username" password="broker_pass";
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
```

### Смотрим список топиков

```
./opt/kafka/bin/kafka-topics.sh --list --bootstrap-server 10.67.7.204:9092 --command-config /opt/kafka/config.properties
```

### Отправить сообщение в топик

```
echo test211234 | ./kafka-console-producer.sh --topic test  --bootstrap-server 10.67.7.204:9092  --producer.config /opt/kafka/config.properties
```

### Посмотреть сообщения в в топике

```
./kafka-console-consumer.sh  --bootstrap-server 10.67.7.204:9092 --topic test --from-beginning --consumer.config /opt/kafka/config.properties
```
