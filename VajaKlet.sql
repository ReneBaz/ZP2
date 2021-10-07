--1. izpiši vse podatke o èlanih (rezultat ima 760 vrstic)
select * from Èlan;

--2. izpiši vse podatke o èlanih, urejene po priimku èlana
select * from Èlan
order by ime;
--3. izpiši vse podatke o èlanih, urejene po številki vasi, nato pa po imenih
select * from Èlan
order by vas,ime;
--4. izpiši ime èlana, naslov in ime vasi, urejene po imenu vasi, nato po imenih èlana
select ime, Naslov, Ime_Vasi from Èlan
inner join Vasi on Èlan.Vas=Vasi.Sifra_vas
order by vas,ime;
--5. izpiši imena èlanov, ki vsebujejo besedo 'FRANC' (17 takih je)
select ime from Èlan
where Ime like '%franc%';
--6. izpiši skupno kolièino pripeljanega grozdja po posameznem èlanu iz tabele prevzem. V izpisu naj bo šifra
-- èlana in skupna kolièina grozdja, izpis uredi po šifri èlana
select sifra_clan, SUM(kolicina) from prevzem
group by sifra_clan;
--7. izpiši skupno kolièino grozdja po letnikih iz tabele Prevzem
select letnik, SUM(kolicina) from prevzem
group by letnik;
--8. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select sorta, SUM(kolicina) from prevzem
where letnik like '2000'
group by sorta;
--9. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno posortah, uporabi imena sort
select sorta.imes, SUM(kolicina) from prevzem
inner join sorta on prevzem.sorta = sorta.sifra_sorta
where letnik like '2000'
group by sorta.imes;
--10. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po odkupni kolièini padajoèe, uporabi imena sort
select sorta.imes, SUM(kolicina) from prevzem
inner join sorta on prevzem.sorta = sorta.sifra_sorta
where letnik like '2000'
group by sorta.imes
order by SUM(kolicina) desc;
--11. kateri èlan je pripeljal najveè grozdja naenkrat? Izpiši šifro èlana (9270120)
select top 1 sifra_clan from prevzem
order by kolicina desc;
--12. izpiši ime èlana, ki je pripeljal najveè grozdja naenkrat (Koncut Damijan)14
select top 1 kolicina, Èlan.ime from prevzem
inner join èlan on prevzem.Sifra_clan = èlan.Sifra_clan
order by kolicina desc;
--13. izpiši šifro èlana, ki je v letu 2003 pripeljal najveè grozdja (9330030)
select top 1 sum(kolicina) as skupaj, sifra_clan from prevzem
where Letnik like '2003'
group by Sifra_clan
order by skupaj desc;
--14. Koliko je vseh èlanov (760)
select COUNT(Sifra_clan) from Èlan;
--15. Koliko èlanov je pripeljalo grozdje v letu 2001 (720)
select count(distinct Sifra_clan) from prevzem
where letnik like '2001' and Kolicina > '0';
--16. Koliko èlanov ni pripeljalo grozdja v letu 2001 (40)
select (select COUNT(Sifra_clan) from Èlan)-count(distinct prevzem.Sifra_clan) from prevzem
where letnik like '2001';
--17. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2001, uredi poimenu
select ime from Èlan
where Sifra_clan not in (select distinct èlan.Sifra_clan from Èlan
inner join Prevzem on Èlan.Sifra_clan = Prevzem.Sifra_clan
where Letnik=2001)
--18. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2000 ali 2001ali 2002 ali 2003, uredi po imenu
select ime from Èlan
where Sifra_clan not in (select distinct èlan.Sifra_clan from Èlan
inner join Prevzem on Èlan.Sifra_clan = Prevzem.Sifra_clan
where Letnik=2000 or Letnik=2001 or Letnik=2002 or Letnik=2003)
--19. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorteskupna kolièina in povpreèna stopnja sladkorje
-- povpreèno sladkorno stopnjo izraèunamo kot povreèje kolièina*sladkor nato delimo skolièino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajoèe
select letnik, imes, sum(Kolicina),sum(Kolicina*Sladkor)/sum(Kolicina) as slst from prevzem
inner join Sorta on Prevzem.Sorta=Sorta.Sifra_sorta
group by Letnik, ImeS
order by Letnik, slst desc;
--20. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorteskupna kolièina in povpreèna stopnja sladkorje
-- povpreèno sladkorno stopnjo izraèunamo kot povpreèje sladkornih stopenj nato delimo s kolièino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajoèe
-- primerjaj rezultate 24. in 25. naloge. Kateri so po tvojem mnenju pravilni? Zakaj?


CREATE TABLE [dbo].[Grozdje](
	[Sifra_sorta] [int] NOT NULL primary key,
	[ImeS] [nvarchar](255) NULL,
	[Sifrav] [int] NULL,
	[SifraUE] [nvarchar](255) NULL,
	[Barva] [nvarchar](255) NULL,
);

insert into Grozdje select*from Sorta;

insert into Grozdje(Sifra_sorta, ImeS) values (5001, 'Laški rizlink');

update sorta set Barva = 'belo' where Barva is null;

