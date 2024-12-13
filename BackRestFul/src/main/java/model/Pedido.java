package model;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Pedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int idCliente;
    @ElementCollection
    private List<Long> idProdutos;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public List<Long> getIdsProdutos() {
        return idProdutos;
    }

    public void setIdsProdutos(List<Long> idsProdutos) {
        this.idProdutos = idsProdutos;
    }
}
