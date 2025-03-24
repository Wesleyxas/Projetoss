class ServiceMap{
  static String mapCodigoService(String codigo){
    switch(codigo) {
      case '04014' :
        return 'SEDEX ';
      case '04510':
        return  'PAC';
      default:
        return 'Serviço desconehcido';
    }
  }
}