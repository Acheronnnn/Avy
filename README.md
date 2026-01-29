# 🎣 Fish It Auto Script

Script Roblox Lua untuk auto fishing di game **Fish It** yang dirancang untuk executor Delta.

## ✨ Fitur

- ✅ **Auto Fishing** - Otomatis cast dan reel
- ✅ **UI Toggle** - Tombol on/off yang mudah digunakan
- ✅ **Draggable UI** - UI bisa dipindah-pindah
- ✅ **Lightweight** - Ringan dan stabil
- ✅ **Easy to Expand** - Mudah dikembangkan untuk fitur tambahan

## 🚀 Cara Penggunaan

### Metode 1: Loadstring (Recommended)

1. Buka game **Fish It** di Roblox
2. Buka executor **Delta**
3. Paste script berikut:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Acheronnnn/Avy/main/fish_it_auto.lua"))()
```

4. Execute script
5. UI akan muncul di layar
6. Equip fishing rod Anda
7. Klik tombol **"Start Auto Fish"** untuk mulai

### Metode 2: Copy-Paste Manual

1. Download file `fish_it_auto.lua`
2. Buka file dengan text editor
3. Copy semua kode
4. Paste ke executor Delta
5. Execute

## 📋 Cara Kerja

Script ini bekerja dengan cara:

1. **Deteksi Rod** - Mencari fishing rod yang sedang equipped
2. **Cast** - Otomatis lempar kail dengan hold duration yang optimal
3. **Wait for Bite** - Menunggu ikan menggigit (dengan timeout)
4. **Reel In** - Otomatis tarik kail
5. **Loop** - Ulangi proses sampai dimatikan

## ⚙️ Konfigurasi

Anda bisa mengubah pengaturan di bagian `Config`:

```lua
local Config = {
    CastHoldTime = 0.8,        -- Durasi hold mouse saat cast (detik)
    WaitAfterCast = 1.5,       -- Delay setelah cast
    MaxWaitForBite = 20,       -- Maksimal waktu tunggu bite
    ReelDelay = 0.5,           -- Delay setelah reel
    RetryDelay = 1,            -- Delay sebelum cast ulang
}
```

## 🔧 Pengembangan Lebih Lanjut

Script ini dirancang modular dan mudah dikembangkan. Beberapa fitur yang bisa ditambahkan:

- [ ] Auto sell ikan
- [ ] Auto upgrade rod
- [ ] Deteksi bite yang lebih akurat
- [ ] Statistik (jumlah ikan, profit, dll)
- [ ] Auto equip rod terbaik
- [ ] Webhook notification
- [ ] Anti-AFK

## 📝 Catatan

- Script ini menggunakan `VirtualInputManager` untuk simulasi input
- Pastikan fishing rod sudah equipped sebelum start
- Jika tidak ada bite dalam 20 detik, script akan otomatis reel
- UI bisa di-drag ke posisi yang Anda inginkan

## ⚠️ Disclaimer

Script ini dibuat untuk tujuan edukasi. Penggunaan script di luar ketentuan Roblox adalah tanggung jawab pengguna.

## 📞 Support

Jika ada bug atau saran, silakan buat issue di repository ini.

---

**Repository:** [github.com/Acheronnnn/Avy](https://github.com/Acheronnnn/Avy)

**Version:** 1.0

**Last Updated:** 29 Januari 2026
