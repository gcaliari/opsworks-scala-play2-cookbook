opsworks-scala-play2-cookbook
=============================

This cookbook is a working prototype allowing the deployment of applications written with the [Play framework](http://www.playframework.com/) on Amazon's [Opsworks](http://aws.amazon.com/opsworks/).
It is based on play2 cookbook by [Originate](https://github.com/Originate/cookbooks/tree/master/play2) but also includes the java and artifact cookbooks referenced by it.

A few minor modifications were needed to update the deploy and execution commands. 


Important Notes :: Throubles
----------------------------
This version of cookbook (v1.0.11) is tested only with Ubuntu 12.04 LTS and use Chef 11.04. Beware when setting up the AWS Stack and instances.
