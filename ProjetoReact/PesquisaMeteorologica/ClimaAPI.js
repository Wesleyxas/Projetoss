import React, { useEffect, useState } from "react";

// VERSÃO FINAL REACT

const Clima = () => {
  const [cidade, setCidade] = useState("");
  const [dadosCidade, setDadosCidade] = useState({});

  useEffect(() => {
    const urlGEOcode = `https://api.openweathermap.org/geo/1.0/direct?q=${cidade}&limit=1&appid=933422e5fe505afa478cb2cbfd30f99d`;

    fetch(urlGEOcode)
      .then((response) => response.json())
      .then((data) => {
        // Verificar se há dados retornados
        if (data.length > 0) {
          const latitude = data[0].lat;
          const longitude = data[0].lon;
          const nome = data[0].name;

          console.log("Latitude:", latitude);
          console.log("Longitude:", longitude);
          console.log("Nome:", nome);

          buscarClima(latitude, longitude, nome);
        } else {
          console.log(
            "Nenhum resultado encontrado para a cidade especificada."
          );
        }
      })
      .catch((error) => {
        console.error("Erro:", error);
      });
  }, [cidade]);

  function buscarClima(latitude, longitude, nome) {
    const urlAPI = `https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&units=metric&appid=933422e5fe505afa478cb2cbfd30f99d&lang=pt_br`;
    fetch(urlAPI)
      .then((response) => response.json())
      .then((weatherData) => {
        // Verificar se os dados necessários estão presentes
        if (
          weatherData &&
          weatherData.weather &&
          weatherData.weather[0] &&
          weatherData.main &&
          weatherData.wind
        ) {
          const descricao = weatherData.weather[0].description;
          const umidade = weatherData.main.humidity;
          const temperatura = weatherData.main.temp;
          const velocidadeVento = weatherData.wind.speed;

          const infoCidade = {
            latitude,
            longitude,
            nome,
            descricao,
            umidade,
            temperatura,
            velocidadeVento,
          };
          setDadosCidade(infoCidade);
        } else {
          console.error("Dados do tempo inválidos:", weatherData);
          lista.innerHTML =
            "<li>Erro ao obter dados do tempo. Formato inválido.</li>";
        }
      });
  }
  return (
    <>
      <div>
        <h2>Nome Cidade: </h2>
        <input
          id="cidade"
          type="text"
          value={cidade}
          onChange={(e) => setCidade(e.target.value)}
        />
      </div>
      <div>
        <ul id="listaClima">
          <li>Latitude: {dadosCidade.latitude} </li>
          <li>Longitude: {dadosCidade.longitude} </li>
          <li>Nome: {dadosCidade.nome} </li>
          <li>Descrição: {dadosCidade.descricao} </li>
          <li>Umidade: {dadosCidade.umidade}%</li>
          <li>Temperatura: {dadosCidade.temperatura} </li>
          <li>Velocida do Vento: {dadosCidade.velocidadeVento} m/s</li>
        </ul>
      </div>
    </>
  );
};

export default Clima;
