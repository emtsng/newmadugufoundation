# Template System Guide

## ✅ Your Project Now Uses a Template System!

All pages are now generated from templates. Header and footer are managed in **ONE place** for all 30 pages.

## 📁 File Structure

### Source Files (Edit These):
- **`templates/components/header.html`** - Header component (used by ALL pages)
- **`templates/components/footer.html`** - Footer component (used by ALL pages)
- **`templates/components/head.html`** - HTML head section
- **`templates/components/scripts.html`** - JavaScript includes
- **`templates/components/sidebar.html`** - Mobile sidebar
- **`templates/components/preloader.html`** - Page preloader
- **`templates/components/search-modal.html`** - Search modal
- **`templates/base.html`** - Main layout template
- **`templates/config.json`** - Site configuration (address, email, etc.)
- **`pages-content/*.html`** - Page content only (no headers/footers)

### Output Files (Generated - Don't Edit):
- **`pages/*.html`** - Full HTML pages (generated from templates)

## 🔄 Workflow

### To Update Header or Footer:

1. **Edit the component file:**
   - Header: `templates/components/header.html`
   - Footer: `templates/components/footer.html`

2. **Rebuild all pages:**
   ```bash
   ruby rebuild-from-content.rb
   ```

3. **Done!** All 30 pages automatically get the updated header/footer.

### To Update Page Content:

1. **Edit the content file:**
   - Example: `pages-content/index.html` (main content only)

2. **Rebuild the page:**
   ```bash
   ruby rebuild-from-content.rb
   ```

### To Update Site Configuration:

1. **Edit `templates/config.json`:**
   ```json
   {
     "site_name": "Madugu Jaji Sambo Foundation",
     "contact_info": {
       "address": "Plot 1015, Fria Close Gwandal Centre, Wuse II, Abuja",
       "email": "info@madugufoundation.com"
     }
   }
   ```

2. **Rebuild all pages:**
   ```bash
   ruby rebuild-from-content.rb
   ```

## 🎯 Key Benefits

✅ **Single Source of Truth** - Header/footer in one place  
✅ **Consistency** - All pages automatically stay in sync  
✅ **Easy Maintenance** - Change once, apply everywhere  
✅ **Professional** - No more editing 30+ files for one change  
✅ **DRY Principle** - Don't Repeat Yourself  

## 📝 Important Notes

- **Don't edit files in `pages/` directly** - They are generated output files
- **Edit source files** in `templates/components/` and `pages-content/`
- **Always run `ruby rebuild-from-content.rb`** after making changes to templates
- The HTML in `pages/` files contains rendered output (this is correct!)

## 🔍 How It Works

1. Template system reads `templates/base.html`
2. Replaces `<%= render 'header.html' %>` with header component
3. Replaces `<%= render 'footer.html' %>` with footer component
4. Inserts page content from `pages-content/`
5. Generates full HTML pages in `pages/`

## 🚀 Quick Start

```bash
# After editing templates/components/header.html or footer.html:
ruby rebuild-from-content.rb

# All 30 pages will be regenerated with the new header/footer!
```

---

**Your template system is now fully operational!** 🎉

