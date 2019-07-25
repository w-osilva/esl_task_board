class Pipeline {
    constructor(element) {
        this.element = $(element);
        if(this.element)
            this._configureForm()
    }

    //private
    _configureForm(){
        // action: Toggle form actions

        let form = $(this.element).find('form')
        let input = $(form).find(".input_new_story")
        let form_actions = $(form).find('.form-actions')

        $(input).on('focus', function(){
            $(form_actions).removeClass('d-none')
        })
        $(input).on('focusout', function(){
            let has_value = !!($(this).val())
            if(! has_value)
                $(this).closest('form').find('.form-actions').addClass('d-none')
        })
        $(form).on('reset', function(){
            $(form_actions).addClass('d-none')
        })
    }
}