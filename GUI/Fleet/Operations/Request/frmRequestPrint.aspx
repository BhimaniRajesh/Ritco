<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmRequestPrint.aspx.cs" Inherits="Request_frmRequestPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vehicle Request</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script language=javascript>
     function printme()
     {
       window.print();
     }
    
    </script>
</head>

<%
 string PrintMode = Request.QueryString["PrintMode"].Trim();
 string tmpFont = "blackfnt";
%>

<%if (PrintMode == "1")
  {
      tmpFont = "blackfnt";
      %>
    <body onload ="printme()">
    <%}
      else
      {
          tmpFont = "bluefnt";
      %>
      <body>
    <%} %>
    <form id="form1" runat="server">
    <div>
    
    
    
    <%
        
        string mydbcon = Session["SqlProvider"].ToString().Trim();//System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(mydbcon);
        
        conn.Open();
        string strReqId = Request.QueryString["Id"].Trim();

        string strMReqId = "";
        string strReqFromDt = "";
        string strReqToDt = "";

        string strReqDt="";
        string strReqBy = "";
        string strCategory = "";
        string strOrgnAddr = "";
        string strOrgnCity = "";
        string strOrgnPin = "";
        string strOrgnLoc = "";
        string strOrgnPhone = "";
        string strOrgnEmail = "";

        string strDestnAddr = "";
        string strDestnCity = "";
        string strDestnPin = "";
        string strDestnLoc = "";
        string strDestnPhone = "";
        string strDestnEmail = "";
        string strVehType = "";
        string strVehClass = "";
        string strVehACNONAC = "";
        string strPassNo = "";
        string strStDttm="";
        string strEdDttm="";


        string strArrivalMode = "";
        string strArriveBy = "";
        string strArriveDt="";
        

      string sql = "usp_RequestViewPrintList";  
      System.Data.SqlClient.SqlCommand sqlcmd1 = new System.Data.SqlClient.SqlCommand(sql, conn);
      sqlcmd1.CommandType= System.Data.CommandType.StoredProcedure;

      sqlcmd1.Parameters.AddWithValue("@ReqId", strReqId);
      sqlcmd1.Parameters.AddWithValue("@ReqFromDt", strReqFromDt);
      sqlcmd1.Parameters.AddWithValue("@ReqToDt", strReqToDt);
        
        
     System.Data.SqlClient.SqlDataReader r1 = sqlcmd1.ExecuteReader();
     
     while (r1.Read())
     {

         strMReqId = r1["Manual_Request_Id"].ToString();
         strReqDt = r1["Request_Dt"].ToString();
         strReqBy = r1["Request_By"].ToString();
         strCategory = r1["CategoryName"].ToString();
         strOrgnAddr = r1["Orgn_address"].ToString();
         strOrgnCity = r1["Orgn_City"].ToString();
         strOrgnPin = r1["Orgn_pin"].ToString();
         strOrgnLoc = r1["Orgn_LocCode"].ToString();
         strOrgnPhone = r1["Orgn_Phone"].ToString();
         strOrgnEmail = r1["Orgn_Email"].ToString();

         strDestnAddr = r1["Destn_address"].ToString();
         strDestnCity = r1["Destn_City"].ToString();
         strDestnPin = r1["Destn_pin"].ToString();
         strDestnLoc = r1["Destn_LocCode"].ToString();
         strDestnPhone = r1["Destn_Phone"].ToString();
         strDestnEmail = r1["Destn_Email"].ToString();

         strVehType = r1["VehType"].ToString();
         strVehClass = r1["VehClass"].ToString();
         strVehACNONAC = r1["AC_NONAC"].ToString();
         strPassNo = r1["No_Passenger"].ToString();

         strStDttm = r1["Start_date_time"].ToString() + " " + r1["Start_time"].ToString();
         strEdDttm = r1["End_dt_tm"].ToString() + " " + r1["End_tm"].ToString();


         strArrivalMode = r1["Arrival_Mode"].ToString();
         strArriveBy = r1["Arrived_By"].ToString();
         strArriveDt = r1["Arrival_Dt"].ToString() + " " + r1["Arrival_tm"].ToString();
        
         
         
     }
     //r1.NextResult();
     r1.Close();

     %>
    
    
    
    
    <p align="center">
        <table cellspacing="1" cellpadding="3" style="width: 85%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="VEHICLE REQUEST FORM"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Request Id</font>
                </td>
                <td align="left">
                   <font class=blackfnt><%=strReqId%></font>
                </td>
                <td align="left">
                <font class=bluefnt>Request Date</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=strReqDt %></font>
                </td>
            </tr>
            
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Manual Request Id</font>
                </td>
                <td align="left" colspan=3>
                   <font class=blackfnt><%=strMReqId%></font>
                </td>
               
            </tr>
            
            
             <tr style="background-color: white">
             
              <td align="left">
                <font class=bluefnt>Category</font>
                </td>
                <td align="left">
                   <font class=blackfnt><%=strCategory%></font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Requested By</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=strReqBy %></font>
                </td>
               
            </tr>
            
        

            
             <tr style="background-color: white">
                <td align="center" colspan=2>
                  <font class=bluefnt><b>Origin</b></font>
                </td>
                <td align="center" colspan=2>
                <font class=bluefnt><b>Destination</b></font>
                </td>
            </tr>
            
              <tr style="background-color: white">
                <td align="left" valign="top">
                  <font class=bluefnt>Address</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=strOrgnAddr%></font>
                </td>
                <td align="left" valign="top">
                <font class=bluefnt>Address</font>
                </td>
                <td align="left">
                  <font class=blackfnt><%=strDestnAddr%></font>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>City-Pin</font>
                </td>
                <td align="left">
                   <font class=blackfnt><%=strOrgnCity %>
                 &nbsp;-&nbsp;
                 <%=strOrgnPin %>
                 </font>
                </td>
                <td align="left">
                <font class=bluefnt>City-Pin</font>
                </td>
                <td align="left">
                
                 <font class=blackfnt><%=strDestnCity %>
                 &nbsp;-&nbsp;
                 <%=strDestnPin %>
                 </font>
                

                </td>
            </tr>
            
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Location</font>
                </td>
                <td align="left">
                 <font class=blackfnt><%=strOrgnLoc %></font>
                </td>
                <td align="left">
                <font class=bluefnt>Location</font>
                </td>
                <td align="left">
                 <font class=blackfnt><%=strDestnLoc %></font>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Phone</font>
                </td>
                <td align="left">
                   <font class=blackfnt><%=strOrgnPhone %></font>
                </td>
                <td align="left">
                <font class=bluefnt>Phone</font>
                </td>
                <td align="left">
                 <font class=blackfnt><%=strDestnPhone %></font>
                </td>
            </tr>
            
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Email</font>
                </td>
                <td align="left">
                 <font class=blackfnt><%=strOrgnEmail %></font>
                </td>
                <td align="left">
                <font class=bluefnt>Email</font>
                </td>
                <td align="left">
                    <font class=blackfnt><%=strDestnEmail %></font>
                </td>
            </tr>
            
            <%--<tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Arrival Details"></asp:Label></td>
            </tr>--%>
            
            
          
            <%--<tr style="background-color: white">
                <td colspan="4" align="left">
                    <table  cellspacing="1" cellpadding="3" style="width: 100%" class="boxbg" border="0">
                       <tr style="background-color: white">
                          <td width ="15%"><font class=bluefnt>Arrival Mode</font></td>
                          <td width="10%"><font class=blackfnt>
                               <%=strArrivalMode%>
                           </font></td>
                           
                          <td width ="10%"><font class=bluefnt>Arrived by</font></td>
                          <td><font class=blackfnt>
                             <%=strArriveBy%>
                          </font></td>
                          
                          <td width ="10%"><font class=bluefnt>Arrived on</font></td>
                          <td><font class=blackfnt>
                          <%=strArriveDt%>
			            </td>
			          </tr>
		          </table>
		       </td>
          </tr>	--%>
            
            
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vehicle Criteria"></asp:Label></td>
            </tr>
             <tr style="background-color: white">
                <td colspan="4" align="left">
                    <table  cellspacing="1" cellpadding="3" style="width: 100%" class="boxbg" border="0">
                       <tr style="background-color: white">
                       
                      
                           <td><font class=bluefnt>Vehicle Type</font></td>
                           <td>
                           <font class=blackfnt><%=strVehType %></font>
                           </td>
                           <%--<td><font class=bluefnt>Vehicle Class</font></td>
                           <td>
                            <font class=blackfnt><%=strVehClass %></font>
                           </td>
                           <td><font class=bluefnt>AC/NON-AC</font></td>
                           <td>
                              <font class=blackfnt><%=strVehACNONAC %></font>
                           </td>
                           <td><font class=bluefnt>No. of Passengers</font></td>
                           <td>  <font class=blackfnt><%=strPassNo %></font></td>--%>
                        </tr>
                       
                    </table>
                
                </td>
              </tr>  
            
            <%--<tr style="background-color: white">
                <td colspan=4 align=center>
                   <table border="0" Width="100%">
                      <tr>
                        <td>
                        
                        <%
                        sql = "Select * from webx_Fleet_Request_PassDetail where Request_Id='" + strReqId + "'";
                        System.Data.SqlClient.SqlCommand sqlcmd2 = new System.Data.SqlClient.SqlCommand(sql, conn);
                        r1 = sqlcmd2.ExecuteReader();
                         %>
                            <table cellspacing="1" cellpadding="3" style="width: 100%" class="boxbg" border="0">
                               <tr class="bgbluegrey">
                                  <td><font class=blackfnt>Sr. No.</font></td>
                                  <td align=left><font class=blackfnt>Passenger Name</font></td>
                                  <td><font class=blackfnt>Gender</font></td>
                                  <td><font class=blackfnt>Age</font></td>
                                  <td align=left><font class=blackfnt>Email</font></td>
                                  <td><font class=blackfnt>Phone No.</font></td>
                               </tr>
                             <% 
                                 int ctr = 1;
                                 while (r1.Read())  
                             {%>
                               <tr  style="background-color: white">
                                  <td width="8%"><font class=blackfnt><%=ctr %>.</font></td>
                                  <td align=left><font class=blackfnt><%=r1["Pass_Name"].ToString()%></font></td>
                                  <td><font class=blackfnt><%=r1["Pass_gender"].ToString()%></font></td>
                                  <td><font class=blackfnt><%=r1["Pass_age"].ToString()%></font></td>
                                  <td align=left><font class=blackfnt><%=r1["Pass_email"].ToString()%></font></td>
                                  <td><font class=blackfnt><%=r1["Pass_mobileno"].ToString()%></font></td>
                               </tr>
                              <%
                                  ctr = ctr + 1;
                                 }
                                 r1.Close();
                                  %> 
                               
                             </table>
                        </td>
                      </tr>
                   </table>    
                </td>
            </tr>--%>
            
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Start date & time</font>
                </td>
                <td align="left">
                <font class=blackfnt><%=strStDttm%></font>
                
                </td>
                <td align="left">
                <font class=bluefnt>End date & time</font>
                </td>
                <td align="left">
                <font class=blackfnt><%=strEdDttm%></font>
                </td>
            </tr>
            
          
        </table>
    <%conn.Close(); %>
    
    
    
    
    </div>
    </form>
</body>
</html>
