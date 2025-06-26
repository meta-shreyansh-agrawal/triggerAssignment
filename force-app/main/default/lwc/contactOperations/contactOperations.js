import { LightningElement, track, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import CreateContactModal from 'c/createContactModal';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Fax', fieldName: 'Fax' },
    {
        type: 'action', typeAttributes:{
            rowActions:[
               { label: 'Edit',name: 'edit'},
               { label: 'Delete',name: 'delete'}
            ]
        }
    }
];

export default class ContactOperations extends LightningElement {
    @track data;
    
    columns = columns;

    @wire(getContactList)
    wiredContacts({ data,error }){
        if(data){
            this.data = data;
        }else if(error){
            this.showToast('Error',error.message,'error');
        }
    }    
    
    async handleNewButton(){
        const result = await CreateContactModal.open(); 
    }

}