--1. non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

select FirstName + ' ' + LastName as FullName, CustomerId, Country
from Customer
where Customer.Country != 'USA'

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.
select *
from Customer 
where Customer.Country = 'Brazil'

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. 
-- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
select FirstName + ' ' + LastName as FullName, InvoiceId, InvoiceDate, BillingCountry
from Invoice i 
		join Customer c
		on c.Country = 'Brazil'

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
select * 
from Employee
where Employee.Title = 'Sales Support Agent'

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
select BillingCountry
from Invoice
group by BillingCountry

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. 
-- The resultant table should include the Sales Agent's full name.
select Employee.FirstName + ' ' + Employee.LastName as EmployeeName, Invoice.InvoiceId, Customer.FirstName + ' ' + Customer.LastName as CustomerName
from Employee
	join Customer
	on Customer.SupportRepId = Employee.EmployeeId
	join Invoice
	on Invoice.CustomerId = Customer.CustomerId

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
select Employee.FirstName + ' ' + Employee.LastName as EmployeeName, Invoice.InvoiceId, Customer.FirstName + ' ' + Customer.LastName as CustomerName, Invoice.Total, Invoice.BillingCountry
from Employee
	join Customer
	on Customer.SupportRepId = Employee.EmployeeId
	join Invoice
	on Invoice.CustomerId = Customer.CustomerId
where Employee.Title = 'Sales Support Agent'
order by EmployeeName

-- total_invoices_year.sql: How many Invoices were there in 2009 and 2011?
select count(1) as NumberOfInvoices, YEAR(Invoice.InvoiceDate) as Date
from Invoice
where Invoice.InvoiceDate >= '01/01/2009'
and Invoice.InvoiceDate <= '12/31/2009'
or  Invoice.InvoiceDate >= '01/01/2011'
and Invoice.InvoiceDate <= '12/31/2011'
group by YEAR(Invoice.InvoiceDate)

-- total_sales_year.sql: What are the respective total sales for each of those years?
select YEAR(Invoice.InvoiceDate) as Date, SUM(Invoice.Total) as Total
from Invoice
where YEAR(Invoice.InvoiceDate) = '2009'
		or YEAR(Invoice.InvoiceDate) = '2011'
group by YEAR(Invoice.InvoiceDate)

-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
select count(1) as NumberOfLineItems
from InvoiceLine
where InvoiceId = 37

-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
select InvoiceId, count(1) as NumberOfLineItems
from InvoiceLine
group by InvoiceId


-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
select Track.Name as TrackName, InvoiceLine.InvoiceLineId as InvoiceLineId
from InvoiceLine
	join Track
	on InvoiceLine.TrackId = Track.TrackId

-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.
select Track.Name as TrackName, Track.Composer as ArtistName, InvoiceLine.InvoiceLineId as InvoiceLineId
from InvoiceLine
	join Track
	on InvoiceLine.TrackId = Track.TrackId

-- country_invoices.sql: Provide a query that shows the # of invoices per country. 
select Invoice.BillingCountry as Country, count(1) as NumberOfInvoices
from Invoice
group by Invoice.BillingCountry

-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. 
-- The Playlist name should be include on the resulant table.
select count(1) as NumberOfTracks, Playlist.Name as PlaylistName
from Playlist
	join PlaylistTrack
	on Playlist.PlaylistId = PlaylistTrack.PlaylistId
group by Playlist.Name

-- Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
select Album.Title as AlbumTitle, MediaType.[Name] as MediaType, Genre.[Name] as Genre
from Track
	join Album
	on Album.AlbumId = Track.AlbumId
	join MediaType
	on MediaType.MediaTypeId = Track.MediaTypeId
	join Genre
	on Track.GenreId = Genre.GenreId
group by Album.Title, MediaType.[Name], Genre.[Name]

-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.
select Invoice.*, count(distinct InvoiceLine.InvoiceLineId) as NumberOfLineItems
from Invoice
	join InvoiceLine
	on Invoice.InvoiceId = InvoiceLine.InvoiceId
group by Invoice.[InvoiceId]
      ,[CustomerId]
      ,[InvoiceDate]
      ,[BillingAddress]
      ,[BillingCity]
      ,[BillingState]
      ,[BillingCountry]
      ,[BillingPostalCode]
      ,[Total]

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
select Employee.FirstName + ' ' + Employee.LastName as FullName, sum(Invoice.Total) as SalesTotal
from Invoice
	join Customer
	on Invoice.CustomerId = Customer.CustomerId
	join Employee
	on Customer.SupportRepId = Employee.EmployeeId
group by Employee.FirstName, Employee.LastName

-- top_2009_agent.sql: Which sales agent made the most in sales in 2009? 
select TOP 1 sum(Invoice.Total) as SalesTotal, Employee.FirstName, Employee.LastName
from Employee
	join Customer
	on Customer.SupportRepId = Employee.EmployeeId
	join Invoice
	on Invoice.CustomerId = Customer.CustomerId
	where YEAR(Invoice.InvoiceDate) = '2009'
group by Employee.FirstName, Employee.LastName
order by sum(Invoice.Total) desc

-- top_agent.sql: Which sales agent made the most in sales over all?
select TOP 1 sum(Invoice.Total) as SalesTotal, Employee.FirstName, Employee.LastName
from Employee
	join Customer
	on Customer.SupportRepId = Employee.EmployeeId
	join Invoice
	on Invoice.CustomerId = Customer.CustomerId
group by Employee.FirstName, Employee.LastName
order by sum(Invoice.Total) desc

-- sales_agent_customer_count.sql: Provide a query that shows the 
-- count of customers assigned to each sales agent.
select Employee.EmployeeId, Employee.FirstName, Employee.LastName, count(distinct Customer.CustomerId) as NumCustomersAssigned
from Employee
	join Customer
	on Customer.SupportRepId = Employee.EmployeeId
where Employee.Title = 'Sales Support Agent'
group by Employee.EmployeeId, Employee.FirstName, Employee.LastName

-- sales_per_country.sql: Provide a query that shows the total sales per country.
select Invoice.BillingCountry, count(1) as SalesPerCountry
from Invoice
group by Invoice.BillingCountry

-- top_country.sql: Which country's customers spent the most?
select TOP 1 sum(Invoice.Total) as TotalSpend, Invoice.BillingCountry
from Invoice
group by Invoice.BillingCountry
order by sum(Invoice.Total) desc

-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.
select count(distinct InvoiceLine.TrackId) as NumberPurchased, InvoiceLine.TrackId
from InvoiceLine
group by InvoiceLine.TrackId
order by count(distinct InvoiceLine.TrackId) desc

-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.
select TOP 5 count(1) as NumberPurchased, Track.[Name], Track.TrackId
from InvoiceLine
	join Track
	on InvoiceLine.TrackId = Track.TrackId
group by Track.TrackId, Track.[Name]
order by count(1) desc

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

select distinct TOP 3 Artist.[Name], count(1) as NumberPurchased, Artist.ArtistId
from InvoiceLine
	join Track
	on InvoiceLine.TrackId = Track.TrackId
	join Album
	on Track.AlbumId = Album.AlbumId
	join Artist
	on Album.ArtistId = Artist.ArtistId
group by Artist.[Name], Artist.ArtistId, Track.TrackId
order by count(1) desc

-- top_media_type.sql: Provide a query that shows the most purchased Media Type.
select TOP 1 count(1) as NumberPurchased, MediaType.[Name]
from InvoiceLine
	join Track
	on InvoiceLine.TrackId = Track.TrackId
	join MediaType
	on MediaType.MediaTypeId = Track.MediaTypeId
group by MediaType.[Name]
order by count(1) desc