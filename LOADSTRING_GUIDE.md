# 📖 Cara Menggunakan Script dengan Loadstring

## 🎯 Loadstring Script

Untuk menjalankan script ini di executor Delta, gunakan kode berikut:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Acheronnnn/Avy/main/fish_it_auto.lua"))()
```

## 📝 Penjelasan Loadstring

### Apa itu Loadstring?

`loadstring()` adalah fungsi Lua yang mengubah string menjadi kode yang bisa dieksekusi. Format yang digunakan:

```lua
loadstring(game:HttpGet("URL_SCRIPT"))()
```

### Cara Kerja:

1. **`game:HttpGet("URL")`** - Mengambil kode script dari GitHub
2. **`loadstring(...)`** - Mengubah string kode menjadi function
3. **`()`** - Menjalankan function tersebut

## 🔗 URL Raw GitHub

URL yang digunakan adalah **raw.githubusercontent.com**, bukan github.com biasa.

### Format URL:
```
https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/FILE
```

### Contoh untuk repository ini:
```
https://raw.githubusercontent.com/Acheronnnn/Avy/main/fish_it_auto.lua
```

## 🚀 Langkah-langkah Lengkap

### 1. Buka Game Fish It
- Masuk ke Roblox
- Join game **Fish It**

### 2. Buka Executor Delta
- Jalankan executor Delta
- Attach ke Roblox

### 3. Paste Script Loadstring
Copy dan paste script ini ke executor:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Acheronnnn/Avy/main/fish_it_auto.lua"))()
```

### 4. Execute
- Klik tombol **Execute** di Delta
- Tunggu beberapa detik
- UI akan muncul di layar

### 5. Mulai Auto Fishing
- Equip fishing rod Anda
- Klik tombol **"Start Auto Fish"**
- Script akan berjalan otomatis

## 🔄 Update Script

Keuntungan menggunakan loadstring:
- ✅ Tidak perlu download ulang
- ✅ Selalu mendapat versi terbaru
- ✅ Update otomatis dari GitHub
- ✅ Lebih praktis dan cepat

Setiap kali Anda execute loadstring, script akan otomatis mengambil versi terbaru dari GitHub.

## ⚠️ Troubleshooting

### Error: "HttpGet is not enabled"
- Pastikan executor Delta sudah support HttpGet
- Coba executor lain yang support HttpGet

### Error: "Unable to load script"
- Cek koneksi internet Anda
- Pastikan URL benar (raw.githubusercontent.com)
- Coba refresh executor

### UI tidak muncul
- Tunggu beberapa detik
- Cek console untuk error message
- Restart Roblox dan coba lagi

### Script tidak jalan
- Pastikan fishing rod sudah equipped
- Cek apakah game Fish It sudah fully loaded
- Lihat console untuk log messages

## 💡 Tips

1. **Bookmark loadstring** - Save loadstring di notepad untuk penggunaan cepat
2. **Cek update** - Lihat repository GitHub untuk update terbaru
3. **Report bug** - Jika ada masalah, buat issue di GitHub
4. **Customize** - Edit konfigurasi di script sesuai kebutuhan

## 📞 Support

Jika ada pertanyaan atau masalah:
- Buat issue di: https://github.com/Acheronnnn/Avy/issues
- Atau hubungi developer

---

**Happy Fishing! 🎣**
