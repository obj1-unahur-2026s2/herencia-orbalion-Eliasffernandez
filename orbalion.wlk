import testOrbalion.*

class Equipo{
    const nombre
    const energiaBase
    const entrenador
    const tecnologias = []

    method nombre(){return nombre}
    method energia(){return energiaBase}
    method entrenador(){return entrenador}
    method tecnologias(){return tecnologias}

    method energiaTotal(){
        return energiaBase + tecnologias.filter({ t => t.activa() })
            .sum({ t => t.valorEnergetico() })
    }


}


class Luminicos inherits Equipo{
    const nivelRadiacion
    const cristalesSolares = []
    
    method nivelRadiacion(){return nivelRadiacion}
    method cristalesSolares(){return cristalesSolares}

   override method energiaTotal() {
    if (self.nivelRadiacion() <= 5000)
        return super() * 1.1
    else
        return super()
    }
    method esDePrestigioUniversal(){
        return self.cristalesSolares().size() >= 3 && self.entrenador().esEliteGalactico()
        && self.tecnologias().any({ t => t.activa() })
    }
}

class Sinteticos inherits Equipo{
    const nivelProcesamiento
    const modulosActivos
    const estanCertificados = true

    method nivelProcesamientoCentral(){return nivelProcesamiento}
    method modulosActivos(){return modulosActivos}
    method estanCertificados(){return estanCertificados}

    override method energiaTotal() {
    if (self.modulosActivos() > 5)
        return super() * 0.8
    else
        return super()
    }
    method esDePrestigioUniversal(){
        return estanCertificados && self.modulosActivos() > 3 && self.tecnologias().all({ t => t.activa() })
    }
}
class Etericos inherits Equipo{
    const nivelFluctuacion
    const portalesEnergeticosAbiertos

    method nivelFluctuacion(){return nivelFluctuacion}
    method portalesEnergeticosAbiertos(){return portalesEnergeticosAbiertos}
    method esDePrestigioUniversal(){
        return nivelFluctuacion > 75 && portalesEnergeticosAbiertos >= 2 && 
        self.tecnologias().filter({ t => t.activa()}).size() >= 2
    }
    override method energiaTotal(){
        if(self.esDePrestigioUniversal()){
            return super() * 1.15
        } else {
        return super()
        }
    }
}

class Tecnologias{
    const nombre
    const valorEnergetico
    const activa = true

    method nombre(){return nombre}
    method valorEnergetico(){return valorEnergetico}
    method activa(){return activa}
}

class Entrenador{
    const ciclosSolares
    const estaEnSintonia = true 
    const nivelPrecisionEstrategica
    var rol

    method ciclosSolares(){return ciclosSolares}
    method estaEnSintonia(){return estaEnSintonia}
    method precisionEstrategica(){return nivelPrecisionEstrategica}
    method rolesHomologados(){roles.validos()}
    method rol() = rol

    method rol(nuevoRol) {
        self.validarRol(nuevoRol)
        rol = nuevoRol
    }
    method validarRol(unRol) {
        if (!roles.validos().contains(unRol)) {
        throw new DomainException(message = "Rol no homologado por la FOZ")
        }
    }
    method esEliteGalactico(){
        return self.ciclosSolares() > 10 and self.rol().esElite(self)
    }

}

object roles{
    method validos() = [estrategaCuantico, arquitectoEnergia, guiaMental]
}
object estrategaCuantico{
    method esElite(unEntrenador) {return unEntrenador.precisionEstrategica() > 80}
}
object arquitectoEnergia{
     method esElite(unEntrenador) {return unEntrenador.estaEnSintonia()}
}
object guiaMental{
    method esElite(unEntrenador) {return true}
}
