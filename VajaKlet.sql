--1. izpi�i vse podatke o �lanih (rezultat ima 760 vrstic)
select * from �lan;

--2. izpi�i vse podatke o �lanih, urejene po priimku �lana
select * from �lan
order by ime;
--3. izpi�i vse podatke o �lanih, urejene po �tevilki vasi, nato pa po imenih
select * from �lan
order by vas,ime;
--4. izpi�i ime �lana, naslov in ime vasi, urejene po imenu vasi, nato po imenih �lana
select ime, Naslov, Ime_Vasi from �lan
inner join Vasi on �lan.Vas=Vasi.Sifra_vas
order by vas,ime;
--5. izpi�i imena �lanov, ki vsebujejo besedo 'FRANC' (17 takih je)
select ime from �lan
where Ime like '%franc%';
--6. izpi�i skupno koli�ino pripeljanega grozdja po posameznem �lanu iz tabele prevzem. V izpisu naj bo �ifra
-- �lana in skupna koli�ina grozdja, izpis uredi po �ifri �lana
select sifra_clan, SUM(kolicina) from prevzem
group by sifra_clan;
--7. izpi�i skupno koli�ino grozdja po letnikih iz tabele Prevzem
select letnik, SUM(kolicina) from prevzem
group by letnik;
--8. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select sorta, SUM(kolicina) from prevzem
where letnik like '2000'
group by sorta;
--9. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno posortah, uporabi imena sort
select sorta.imes, SUM(kolicina) from prevzem
inner join sorta on prevzem.sorta = sorta.sifra_sorta
where letnik like '2000'
group by sorta.imes;
--10. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po odkupni koli�ini padajo�e, uporabi imena sort
select sorta.imes, SUM(kolicina) from prevzem
inner join sorta on prevzem.sorta = sorta.sifra_sorta
where letnik like '2000'
group by sorta.imes
order by SUM(kolicina) desc;
--11. kateri �lan je pripeljal najve� grozdja naenkrat? Izpi�i �ifro �lana (9270120)
select top 1 sifra_clan from prevzem
order by kolicina desc;
--12. izpi�i ime �lana, ki je pripeljal najve� grozdja naenkrat (Koncut Damijan)14
select top 1 kolicina, �lan.ime from prevzem
inner join �lan on prevzem.Sifra_clan = �lan.Sifra_clan
order by kolicina desc;
--13. izpi�i �ifro �lana, ki je v letu 2003 pripeljal najve� grozdja (9330030)
select top 1 sum(kolicina) as skupaj, sifra_clan from prevzem
where Letnik like '2003'
group by Sifra_clan
order by skupaj desc;
--14. Koliko je vseh �lanov (760)
select COUNT(Sifra_clan) from �lan;
--15. Koliko �lanov je pripeljalo grozdje v letu 2001 (720)
select count(distinct Sifra_clan) from prevzem
where letnik like '2001' and Kolicina > '0';
--16. Koliko �lanov ni pripeljalo grozdja v letu 2001 (40)
select (select COUNT(Sifra_clan) from �lan)-count(distinct prevzem.Sifra_clan) from prevzem
where letnik like '2001';
--17. izpi�i imena in naslove �lanov, ki niso pripeljali grozdja v letu 2001, uredi poimenu
select ime from �lan
where Sifra_clan not in (select distinct �lan.Sifra_clan from �lan
inner join Prevzem on �lan.Sifra_clan = Prevzem.Sifra_clan
where Letnik=2001)
--18. izpi�i imena in naslove �lanov, ki niso pripeljali grozdja v letu 2000 ali 2001ali 2002 ali 2003, uredi po imenu
select ime from �lan
where Sifra_clan not in (select distinct �lan.Sifra_clan from �lan
inner join Prevzem on �lan.Sifra_clan = Prevzem.Sifra_clan
where Letnik=2000 or Letnik=2001 or Letnik=2002 or Letnik=2003)
--19. izpi�i povpre�no sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorteskupna koli�ina in povpre�na stopnja sladkorje
-- povpre�no sladkorno stopnjo izra�unamo kot povre�je koli�ina*sladkor nato delimo skoli�ino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajo�e
select letnik, imes, sum(Kolicina),sum(Kolicina*Sladkor)/sum(Kolicina) as slst from prevzem
inner join Sorta on Prevzem.Sorta=Sorta.Sifra_sorta
group by Letnik, ImeS
order by Letnik, slst desc;
--20. izpi�i povpre�no sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorteskupna koli�ina in povpre�na stopnja sladkorje
-- povpre�no sladkorno stopnjo izra�unamo kot povpre�je sladkornih stopenj nato delimo s koli�ino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajo�e
-- primerjaj rezultate 24. in 25. naloge. Kateri so po tvojem mnenju pravilni? Zakaj?


CREATE TABLE [dbo].[Grozdje](
	[Sifra_sorta] [int] NOT NULL primary key,
	[ImeS] [nvarchar](255) NULL,
	[Sifrav] [int] NULL,
	[SifraUE] [nvarchar](255) NULL,
	[Barva] [nvarchar](255) NULL,
);

insert into Grozdje select*from Sorta;

insert into Grozdje(Sifra_sorta, ImeS) values (5001, 'La�ki rizlink');

update sorta set Barva = 'belo' where Barva is null;

