SELECT 	FilmKlient.IdKlienta, FilmKlient.IdFilmu, FilmKlient.DataWyp, FilmKlient.DataZwrotu,
 		IIf(DataZwrotu Is Null,DateDiff("d",DataWyp,Now()) & " dni",
 		DateDiff("d",DataWyp,DataZwrotu) & " dni") AS [Dni u klienta],
 		IIf([FilmKlient].DataZwrotu Is Null,
 		IIf(DateDiff("d",[DataWyp],Date())>30,DateDiff("d",[DataWyp],Date())-30 & " dni",Null),
 		IIf(DateDiff("d",[FilmKlient].DataWyp,[FilmKlient].DataZwrotu)>30,
 		(DateDiff("d",[FilmKlient].DataWyp,[FilmKlient].DataZwrotu)-30 & " dni"),Null)) 
 		AS Przedluzenie,
 		IIf([Przedluzenie] Is Null,Null,CCur((DateDiff("d",[DataWyp],Now())-30))*
 		CCur(Stawki.Stawka*0.1)) AS [Kara za przed],
 		FilmKlient.Uszkodzenia, 
 		IIf([Uszkodzenia]=True,CCur([Film]![Cena]*0.5),Null) AS [Kara za uszkodzenia],
 		IIf(([Kara za przedl] Is Not Null) Or ([Kara za uszkodzenia] Is Not Null),
 		CCur((NZ([Kara za przedl])+NZ([Kara za uszkodzenia]))),Null) AS [Kara lacznie]
		
 FROM 	FilmKlient, Klient, Film, Stawki
 
 WHERE 	(((FilmKlient.IdKlienta)=[Klient].[IdKlienta]) AND 
 		((FilmKlient.IdFilmu)=[Film].[IdFilmu]) AND 
 		((Stawki.IdStawki)=[Film].[IdStawki]))
 		
 ORDER BY Klient.Nazwisko, Klient.Imie;
