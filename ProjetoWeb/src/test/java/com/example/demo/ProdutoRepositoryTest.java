package com.example.demo;


import com.example.demo.persistence.ProdutoRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
public class ProdutoRepositoryTest {

    @Autowired
    private ProdutoRepository produtoRepository;

    @Test
    public void quandoSalvarProduto_entaoEncontrarPorNome() {
        Produto produto = new Produto();
         produto.setNome("Notebook");
        ProdutoRepository.save(produto);

        Optional<Produto> encontrado = produtoRepository.findByNome("notebook");
        Optional<Produto> encontrado = produtoRepository.findById(1L);
        assertTrue(encontrado.isPresent());
        produto = encontrado.get();
        assertEquals("notebook", produto.getNome());
    }
}
