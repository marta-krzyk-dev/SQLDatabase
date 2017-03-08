SELECT DISTINCT Film.tytul,Film.cena, s.stawka, 
        COUNT(FilmKlient.idfilmu) AS [Ilość wyp], 
        [Ilość wyp]*s.stawka AS [Zysk z wyp], 
        [Zysk z wyp]-Film.Cena AS [Zysk z wyp-cena filmu], 
        ([Zysk z wyp]/[Film.Cena]) AS [Zwrot ceny filmu]
      
 FROM   Stawki AS s INNER JOIN (Film LEFT JOIN FilmKlient ON
        Film.IdFilmu=FilmKlient.IdFilmu) ON s.IdStawki=Film.IdStawki
      
 GROUP BY Film.tytul, Film.Cena, s.stawka
 
 ORDER BY 6 DESC;
