/*!
 * FormValidation (http://formvalidation.io)
 * The best jQuery plugin to validate form fields. Support Bootstrap, Foundation, Pure, SemanticUI, UIKit and custom frameworks
 *
 * @version     v0.7.0-dev, built on 2015-06-04 4:32:32 PM
 * @author      https://twitter.com/formvalidation
 * @copyright   (c) 2013 - 2015 Nguyen Huu Phuoc
 * @license     http://formvalidation.io/license/
 */
!function (a) {
    FormValidation.Framework.Bootstrap = function (b, c, d) {
        c = a.extend(!0, {
            button: {selector: '[type="submit"]:not([formnovalidate])', disabled: "disabled"},
            err: {clazz: "help-block", parent: "^(.*)col-(xs|sm|md|lg)-(offset-){0,1}[0-9]+(.*)$"},
            icon: {valid: null, invalid: null, validating: null, feedback: "form-control-feedback"},
            row: {selector: ".form-group", valid: "has-success", invalid: "has-error", feedback: "has-feedback"}
        }, c), FormValidation.Base.apply(this, [b, c, d])
    }, FormValidation.Framework.Bootstrap.prototype = a.extend({}, FormValidation.Base.prototype, {
        _fixIcon: function (a, b) {
            var c = this._namespace, d = a.attr("type"), e = a.attr("data-" + c + "-field"), f = this.options.fields[e].row || this.options.row.selector, g = a.closest(f);
            if ("checkbox" === d || "radio" === d) {
                var h = a.parent();
                h.hasClass(d) ? b.insertAfter(h) : h.parent().hasClass(d) && b.insertAfter(h.parent())
            }
            0 === g.find("label").length && b.addClass("fv-icon-no-label"), 0 !== g.find(".input-group").length && b.addClass("fv-bootstrap-icon-input-group").insertAfter(g.find(".input-group").eq(0))
        }, _createTooltip: function (a, b, c) {
            var d = this._namespace, e = a.data(d + ".icon");
            if (e)switch (c) {
                case"popover":
                    e.css({cursor: "pointer", "pointer-events": "auto"}).popover("destroy").popover({
                        container: "body",
                        content: b,
                        html: !0,
                        placement: "auto top",
                        trigger: "hover click"
                    });
                    break;
                case"tooltip":
                default:
                    e.css({cursor: "pointer", "pointer-events": "auto"}).tooltip("destroy").tooltip({
                        container: "body",
                        html: !0,
                        placement: "auto top",
                        title: b
                    })
            }
        }, _destroyTooltip: function (a, b) {
            var c = this._namespace, d = a.data(c + ".icon");
            if (d)switch (b) {
                case"popover":
                    d.css({cursor: "", "pointer-events": "none"}).popover("destroy");
                    break;
                case"tooltip":
                default:
                    d.css({cursor: "", "pointer-events": "none"}).tooltip("destroy")
            }
        }, _hideTooltip: function (a, b) {
            var c = this._namespace, d = a.data(c + ".icon");
            if (d)switch (b) {
                case"popover":
                    d.popover("hide");
                    break;
                case"tooltip":
                default:
                    d.tooltip("hide")
            }
        }, _showTooltip: function (a, b) {
            var c = this._namespace, d = a.data(c + ".icon");
            if (d)switch (b) {
                case"popover":
                    d.popover("show");
                    break;
                case"tooltip":
                default:
                    d.tooltip("show")
            }
        }
    }), a.fn.bootstrapValidator = function (b) {
        var c = arguments;
        return this.each(function () {
            var d = a(this), e = d.data("formValidation") || d.data("bootstrapValidator"), f = "object" == typeof b && b;
            e || (e = new FormValidation.Framework.Bootstrap(this, a.extend({}, {
                events: {
                    formInit: "init.form.bv",
                    formPreValidate: "prevalidate.form.bv",
                    formError: "error.form.bv",
                    formSuccess: "success.form.bv",
                    fieldAdded: "added.field.bv",
                    fieldRemoved: "removed.field.bv",
                    fieldInit: "init.field.bv",
                    fieldError: "error.field.bv",
                    fieldSuccess: "success.field.bv",
                    fieldStatus: "status.field.bv",
                    localeChanged: "changed.locale.bv",
                    validatorError: "error.validator.bv",
                    validatorSuccess: "success.validator.bv"
                }
            }, f), "bv"), d.addClass("fv-form-bootstrap").data("formValidation", e).data("bootstrapValidator", e)), "string" == typeof b && e[b].apply(e, Array.prototype.slice.call(c, 1))
        })
    }, a.fn.bootstrapValidator.Constructor = FormValidation.Framework.Bootstrap
}(jQuery);