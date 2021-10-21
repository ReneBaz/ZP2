--1. Napi�ite poizvedbo, ki vra�a ID produkta, ime produkta z velikimi tiskanimi �rkami in stolpec
--Te�a, ki zaokro�i te�no na prvo celo �tevilo.
select [ProductID],[Name],round([Weight],0) from [SalesLT].[Product];
--2. Raz�irite prvo poizvedbo tako, da dodate LetoZa�etkaProdaja, ki vsebuje leto atributa
--SellStartDate in MesecZa�Prodaje, ki vsebuje mesec istega atributa. V stolpcu naj bo ime
--meseca (na primer 'January')
select [ProductID],[Name],round([Weight],0),year([SellStartDate]) as leto,datename(mm,[SellStartDate]) as mesec from [SalesLT].[Product];
--3. Dodajte poizvedbi �e stolpec z imenom Tip, ki vsebuje prvi dve �rki atributa ProductNumber.
select [ProductID],[Name],round([Weight],0),year([SellStartDate]) as leto,datename(mm,[SellStartDate]) as mesec, left([ProductNumber],2)from [SalesLT].[Product];
--4. Dodajte poizvedbi �e filter, tako da bodo rezultat samo tisti produkti, ki imajo pod atributom
--Size napisano �tevilo (ne pa 'S', 'M' ali 'L')
select [ProductID],[Name],round([Weight],0),year([SellStartDate]) as leto,datename(mm,[SellStartDate]) as mesec, left([ProductNumber],2),[Size]
from [SalesLT].[Product]
where ISNUMERIC(size)=1;