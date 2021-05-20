var app=angular.module("somemodule",[]);

app.controller("modulectrl", func1);

function func1($http)
{
	var maeth=Math.floor(Math.random()*10000);
	this.passcode=maeth;
	this.showuser=true;
	this.showadmin=false;
	this.some=true;
	this.flightdetails=false;
	this.bookdetails=false;
	this.showfilteredflights=false;
	this.showeditdetails=false;
	this.paymentdetails=false;
	console.log(this.passcode)
	
	
	this.user=function(){
		this.showuser=true;
		this.showadmin=false;
	}
	
	this.admin=function(){
		this.showuser=false;
		this.showadmin=true;
	}
	
	this.showflightdetails=function(){
		this.flightdetails=true;
		var self=this;
		$http({
			method : "GET",
			 url : "/FlightBookingSystemServlet/GetFlight"
		}).then(function success(response){
			self.flights=response.data;
		},function myError(response) {
		      self.flights = response.statusText;});
	}
	
	this.hideflightdetails=function(){
		this.flightdetails=false;
	}
	
	this.showbookingdetails=function()
	{
		this.bookdetails=true;
		var self=this;
		$http({
			method : "GET",
			 url : "/FlightBookingSystemServlet/GetBookings"
		}).then(function success(response){
			self.bookings=response.data;
		},function myError(response) {
		      self.bookings = response.statusText;});
	}
	
	this.hidebookingdetails=function()
	{
		this.bookdetails=false;
	}
	
	
	this.collectdata=function(){
		this.showfilteredflights=true;
		var self=this;
		$http({
			method : "GET",
			 url : "/FlightBookingSystemServlet/GetFlight"
		}).then(function success(response){
			self.flights=response.data;
			console.log(self.flights);
		},function myError(response) {
		      self.flights = response.statusText;});
	}
	
	this.book=function(flightid){
		this.fid=flightid;
		this.paymentdetails=true;
		var data=
		{
				nos:this.nof,
				fid:this.fid,
				meal:this.mp
		}
		
		$http.post("/FlightBookingSystemServlet/PostFlight" ,JSON.stringify(data)
				).then(function (response){
			console.log(response);
			alert("booking successfull");
		});
		
	}
	
	this.getpaymentdetails=function()
	{
		console.log("here")
		var self=this;
		$http({
			method : "GET",
			 url : "/FlightBookingSystemServlet/GetPaymentdDetails"
		}).then(function success(response){
			self.payment=response.data;
		},function myError(response) {
		      self.payment = response.statusText;});
	}
	
	this.cancel=function(bookid)
	{
		this.bid=bookid;
		var data=
		{
				bookid:this.bid
		}
		$http.post("/FlightBookingSystemServlet/PostUser" ,JSON.stringify(data)
		).then(function (response){
			console.log(response);
			alert("cancellation successfull");
		});
	}
	
	this.addflight = function()
	{
		var data={
				name:this.name,
				sno:this.sno,
				start:this.start,
				final:this.final,
				dof:this.dof,
				departure:this.departure,
				arrival:this.arrival,
				tnos:this.tnos,
				nos:this.nos,
				tp:this.ticket,
				mp:this.meals
		}
		
		$http.post("/FlightBookingSystemServlet/PostFlightData",JSON.stringify(data)
				).then(function success(response){
					alert("Flight Added Successfully");
				})
	}
	
	this.editflight=function(thisflightdata)
	{
		this.tfd=thisflightdata;
		this.showeditdetails=true;
	}
	
	this.doneedit=function()
	{
		this.showeditdetails=false;
		this.tfd.dof=this.newdate;
		console.log(this.tfd);
		$http.post("/FlightBookingSystemServlet/PostEditFlight",JSON.stringify(this.tfd)
		).then(function success(response){
			alert("Flight Edited Successfully");
		})
	}
	
	this.deleteflight=function(deleteflightid)
	{
		this.dfi=deleteflightid;
		var data={
				id:this.dfi
		}
		$http.post("/FlightBookingSystemServlet/PostDeleteFlight",JSON.stringify(data)
		).then(function success(response){
			alert("Flight Deleted Successfully");
		})
	}
	
	this.canceledit=function()
	{
		this.showeditdetails=false;
	}
}