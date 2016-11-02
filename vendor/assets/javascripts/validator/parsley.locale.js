Parsley.addMessages('en', {
  defaultMessage: "Value is invalid.",
  type: {
    email:        "Value should be a valid email.",
    url:          "Value should be a valid url.",
    number:       "Value should be a valid number.",
    integer:      "Value should be a valid integer.",
    digits:       "Value should be digits.",
    alphanum:     "Value should be alphanumeric."
  },
  notblank:       "Value should not be blank.",
  required:       "Value is required.",
  pattern:        "Value is invalid.",
  min:            "Value should be greater than or equal to %s.",
  max:            "Value should be lower than or equal to %s.",
  range:          "Value should be between %s and %s.",
  minlength:      "Value is too short. It should have %s characters or more.",
  maxlength:      "Value is too long. It should have %s characters or fewer.",
  length:         "Value length is invalid. It should be between %s and %s characters long.",
  mincheck:       "You must select at least %s choices.",
  maxcheck:       "You must select %s choices or fewer.",
  check:          "You must select between %s and %s choices.",
  equalto:        "Value should be the same."
});

Parsley.setLocale('en');
