import { LightningElement } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Fax', fieldName: 'Fax' }

];

export default class ContactOperations extends LightningElement {

    data = [];
    columns = columns;

    async connectedCallback() {
        try {
            this.data = await getContactList();
            this.error = undefined;
        } catch (error) {
            this.contacts = undefined;
            this.error = error;
        }
    }

}