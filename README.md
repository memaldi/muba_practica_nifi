## Clonar este repositorio desde la terminal de AWS Academy

El primer paso consiste en clonar este mismo repositorio en la terminal de AWS Academy:

```
git clone https://github.com/memaldi/muba_practica_nifi
```

## Lanzar máquina virtual en Amazon EC2

En primer lugar, vamos a lanzar la máquina virtual en la que vamos a instalar NiFi. Para ello, el primer paso es crear el grupo de seguridad que nos va a permitir conectarnos al puerto en el cual escuchará Nifi (`8880`).

```
aws ec2 create-security-group --group-name nifi-sg --description "Grupo de seguridad para Apache NiFi"
```

Este comando mostrará por pantalla el ID del grupo de seguridad recién creado, algo del estilo:

```
{
    "GroupId": "sg-0cb53ff8a15918ac0"
}
```

Es importante conservar este identificador, ya que lo necesitaremos para comandos posteriores. Una vez creado el grupo de seguridad, habilitaremos la regla de entrada que permitirá que nos conectemos a NiFi. Recuerda sustituir `<GroupId>` por el ID de tu grupo de seguridad.

```
aws ec2 authorize-security-group-ingress --group-id <GroupId> --protocol tcp --port 8880 --cidr 0.0.0.0/0
```

Una vez creado el grupo de seguridad y las reglas necesarias, podemos proceder a crear la máquina virtual. Este comando va a crear una máquina virtual que tendrá asociado el grupo de seguridad creado anteriormente. No olvides sustituir `<GroupId>` por el ID de tu grupo de seguridad.

```
aws ec2 run-instances --image-id ami-0532be01f26a3de55 --count 1 --instance-type t2.medium --key-name vockey --security-group-ids <GroupId> --region us-east-1  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=NiFi}]' --user-data file://muba_practica_nifi/userdata.sh
```
