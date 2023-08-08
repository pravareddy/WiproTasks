import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class UpdateEmailByQuickActionInContact extends  NavigationMixin(LightningElement) {
    // Navigation to lightning component
    navigateToLightningComponent() {
        this[NavigationMixin.Navigate]({
            "type": "standard__component",
            "attributes": {
                //Here customLabelExampleAura is name of lightning aura component
                //This aura component should implement lightning:isUrlAddressable
                "componentName": "c__updateEmailByLwc"
            }
        });
    }
}