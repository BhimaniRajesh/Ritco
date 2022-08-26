<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectGodown.aspx.cs" Inherits="GUI_Operations_UpdateDocketArrivalStatus_SelectGodown" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head runat="server">
    
        <title>
            Godown List
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">   
            
            function disableenter()
            {
            
            }
            
            function ResetAll()
            {
                var mControlName = "<%=strQSParam %>"
                
                if(window.opener.document.getElementById(mControlName))
                {
                    window.opener.document.getElementById(mControlName).value = ""
                }
                
                var mDerivedControlName = "";
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptGodown$ctl" + "0" + i + "$"
                    }
                    else
                    {
                        mDerivedControlName = "rptGodown$ctl" + i + "$"
                    }
                    
                    //de-select the radio button
                    if(document.getElementById(mDerivedControlName))
                    {
                        document.getElementById(mDerivedControlName).checked = false;
                    }
                }
            }
        
            function SelectGodown(objCondition)
            {
                var mControlName = "<%=strQSParam %>"
                
                if(window.opener.document.getElementById(mControlName))
                {
                    window.opener.document.getElementById(mControlName).value = objCondition.value
                }
                
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                var mSelectedControlName = objCondition.name;
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptGodown$ctl" + "0" + i + "$"
                    }
                    else
                    {
                        mDerivedControlName = "rptGodown$ctl" + i + "$"
                    }
                    
                    //Match the selected control name with derived control name
                    if (mSelectedControlName != mDerivedControlName)
                    {
                        //If different then, de-select the radio button
                        if(document.getElementById(mDerivedControlName))
                        {
                            document.getElementById(mDerivedControlName).checked = false;
                        }
                    }
                }
                
                if(document.getElementById("radReset"))
                {
                    if(document.getElementById("radReset").checked == true)
                    {
                        document.getElementById("radReset").checked = false;
                    }
                }
            }

        </script>
        
    </head>

    <body>
        
        <form id="frmArrivalCondition" runat="server">
        
            <div>
                
                <table border="0" width="100%" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td style="width: 5%">
                            &nbsp;
                        </td>
                        
                        <td style="width: 25%" align="left">
                            <label class="blackfnt">
                                Godown Id
                            </label>
                        </td>
                        
                        <td align="left">
                            <label class="blackfnt">
                                Godown Name
                            </label>
                        </td>
                    </tr>
                    
                    <tr style="background-color: White">
                        <td style="width: 5%" align="center">
                            <input type="radio" runat="server" id="radReset" onclick="ResetAll()" />
                        </td>
                        
                        <td style="width: 25%" align="left">
                            &nbsp;
                        </td>
                        
                        <td align="left">                           
                            <label class="blackfnt">
                                Reset The Value
                            </label>
                        </td>
                    </tr>
                    
                    <asp:Repeater ID="rptGodown" runat="server">
                        <ItemTemplate>
                            <tr style="background-color: White">
                                <td style="width: 5%" align="center">
                                    <input id="radSelGodown" type="radio" value='<%#DataBinder.Eval(Container.DataItem, "Godown_ID_Name")%>' 
                                        GName='<%#DataBinder.Eval(Container.DataItem, "Godown_NAME")%>' 
                                        onclick="SelectGodown(this)" runat="server" />
                                </td>
                                
                                <td style="width: 25%" align="left">
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Godown_ID")%>
                                    </label>
                                </td>
                                
                                <td align="left">
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Godown_NAME")%>
                                    </label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
                
            </div>
        
        </form>
        
    </body>

</html>
