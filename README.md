# Scala and sbt Dockerfile

This repository contains **Dockerfile** of [Scala](http://www.scala-lang.org) and [sbt](http://www.scala-sbt.org).


## Base Docker Image ##

* [openjdk](https://hub.docker.com/_/openjdk)
* [hseeberger/scala-sbt](https://hub.docker.com/r/hseeberger/scala-sbt)


## Installation ##

1. Install [Docker](https://www.docker.com)
2. Pull [automated build](https://hub.docker.com/r/florentpeyron/scala-sbt-ecr/) from public [Docker Hub Registry](https://registry.hub.docker.com):
```
docker pull florentpeyron/scala-sbt/scala-sbt-ecr
```

Alternatively, you can build an image from Dockerfile: 
```
docker build -t fpeyron/scala-sbt-ecr github.com/fpeyron/scala-sbt-ecr
``


```
docker build -t florentpeyron/scala-sbt-ecr:latest .
```


## Usage ##

```
docker run -it --rm -v /Users/florentpeyron/dev/swan/swan-ledger:/opt fpeyron/scala-sbt-ecr:latest /bin/bash
```

### Alternative commands ###
The container contains `bash`, `scala` and `sbt`.

```
docker run -it --rm 517903064498.dkr.ecr.eu-west-3.amazonaws.com/io.swan/scala-sbt/scala-sbt scala
```

### Non-root ###
The container is prepared to be used with a non-root user called `sbtuser`

```
docker run -it --rm -u sbtuser -w /home/sbtuser 517903064498.dkr.ecr.eu-west-3.amazonaws.com/io.swan/scala-sbt/scala-sbt
```

## Contribution policy ##

Contributions via GitHub pull requests are gladly accepted from their original author. Along with any pull requests, please state that the contribution is your original work and that you license the work to the project under the project's open source license. Whether or not you state this explicitly, by submitting any copyrighted material via pull request, email, or other means you agree to license the material under the project's open source license and warrant that you have the legal authority to do so.


## License ##

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").
